import os
import json
import re
import sys

# --- CONFIGURATION ---
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Pointing to the current directory dynamically for the Demo
BASE_DIRECTORIES = [
    BASE_DIR
]

# Leave empty to automatically process any .pbip found in the directory
TARGET_REPORTS = []

MASTER_FILE = os.path.join(BASE_DIR, "AccumulatedPBIPMetadata.txt")


def parse_model_bim(bim_path):
    """
    Parses a standard model.bim (JSON) file to extract tables, columns, 
    measures, and relationships.
    """
    with open(bim_path, 'r', encoding='utf-8-sig') as file:
        data = json.load(file)
        
    model = data.get("model", {})
    tables_data = []
    measures_data = []
    
    for table in model.get("tables", []):
        table_name = table.get("name", "Unknown")
        
        # Extract columns
        columns = [
            {"name": col.get("name"), "dataType": col.get("dataType")} 
            for col in table.get("columns", [])
        ]
        tables_data.append({"name": table_name, "columns": columns})
        
        # Extract measures
        for measure in table.get("measures", []):
            measures_data.append({
                "table": table_name, 
                "name": measure.get("name"),
                "expression": measure.get("expression", ""), 
                "displayFolder": measure.get("displayFolder", "")
            })
            
    return tables_data, measures_data, model.get("relationships", [])


def parse_tmdl_folder(definition_dir):
    """
    Parses a Power BI TMDL definition folder format to extract tables, 
    columns, and measures using regular expressions.
    """
    tables_data = []
    measures_data = []
    relationships_data = []
    
    tables_dir = os.path.join(definition_dir, "tables")
    if not os.path.exists(tables_dir): 
        return tables_data, measures_data, relationships_data
    
    for filename in os.listdir(tables_dir):
        if not filename.endswith(".tmdl"): 
            continue
            
        with open(os.path.join(tables_dir, filename), 'r', encoding='utf-8-sig') as file:
            content = file.read()
            
        table_name = filename.replace(".tmdl", "")
        columns = []
        
        # Identify each column block and capture its inner content
        column_matches = re.finditer(r"column\s+'?([^'\n]+)'?(.*?)(?=column\s|measure\s|\Z)", content, re.DOTALL)
        
        for match in column_matches:
            col_name = match.group(1).strip()
            col_body = match.group(2)
            
            # Extract the dataType within the column definition block
            dt_match = re.search(r"dataType:\s*([^\n\s]+)", col_body)
            col_type = dt_match.group(1) if dt_match else "" 
            
            columns.append({"name": col_name, "dataType": col_type})
            
        tables_data.append({"name": table_name, "columns": columns})
        
        # Split content by the 'measure' keyword to process DAX expressions
        measure_blocks = re.split(r"measure\s+", content)[1:]
        
        for block in measure_blocks:
            measure_match = re.match(r"'?([^'=]+)'?\s*=\s*(.*)", block, re.DOTALL)
            
            if measure_match:
                measure_name = measure_match.group(1).strip()
                
                # Clean the DAX code by removing subsequent TMDL property tags
                clean_dax = re.split(r"\n\s*(formatString:|displayFolder:|lineageTag:|column\s|partition\s)", measure_match.group(2))[0].strip()
                
                # Clean native TMDL backticks to avoid confusing the AI
                clean_dax = clean_dax.replace("```dax", "").replace("```", "").strip()
                
                # Extract display folder if available
                folder_match = (re.search(r'displayFolder:\s*"([^"]+)"', block) or re.search(r'displayFolder:\s*([^"\n\s]+)', block))
                
                measures_data.append({
                    "table": table_name, 
                    "name": measure_name, 
                    "expression": clean_dax,
                    "displayFolder": folder_match.group(1) if folder_match else ""
                })
                
    return tables_data, measures_data, relationships_data


def main():
    print("Starting targeted metadata extraction process...")
    all_data = []
    found_reports = []

    for base_dir in BASE_DIRECTORIES:
        if not os.path.exists(base_dir):
            print(f"Warning: Cannot access directory: {base_dir}")
            continue
            
        print(f"Scanning directory: {base_dir}")

        for root, dirs, files in os.walk(base_dir):
            # Ignore virtual environments and git repositories to speed up traversal
            if '.venv' in dirs: dirs.remove('.venv')
            if '.git' in dirs: dirs.remove('.git')
            
            for dir_name in dirs:
                if dir_name.endswith(".SemanticModel"):
                    project_name = dir_name.replace(".SemanticModel", "").strip() 
                    
                    # Filter by target reports if defined
                    if TARGET_REPORTS and project_name not in TARGET_REPORTS:
                        continue 
                    
                    print(f"   Analyzing project: {project_name}")
                    model_path = os.path.join(root, dir_name)
                    tables = []
                    measures = []
                    relationships = []
                    
                    # Check for legacy BIM format or modern TMDL format
                    if os.path.exists(os.path.join(model_path, "model.bim")):
                        tables, measures, relationships = parse_model_bim(os.path.join(model_path, "model.bim"))
                    elif os.path.exists(os.path.join(model_path, "definition")):
                        tables, measures, relationships = parse_tmdl_folder(os.path.join(model_path, "definition"))
                    
                    if tables or measures:
                        all_data.append({
                            "report_name": project_name,
                            "folder_path": root,  # Path reference used by the AI for output allocation
                            "tables": tables,
                            "measures": measures,
                            "relationships": relationships
                        })
                        found_reports.append(project_name)

    # Validation check for missing target reports
    if TARGET_REPORTS:
        missing_reports = set(TARGET_REPORTS) - set(found_reports)
        if missing_reports:
            print("\nWarning: The following target models were not found:")
            for missing in missing_reports: 
                print(f"   - {missing}")

    # Output generation
    if all_data:
        with open(MASTER_FILE, "w", encoding="utf-8") as output_file:
            json.dump(all_data, output_file, indent=2, ensure_ascii=False)
        print(f"\nSuccess: {len(all_data)} reports successfully extracted and saved to {MASTER_FILE}")
    else:
        print("\nError: No metadata was extracted. Please check the paths and target reports.")


if __name__ == "__main__":
    main()