<document_structure>
Follow exactly this structure. Populate Sections 1-3 using a high-level architectural tone.

# Technical Design & Specifications

## 1. Introduction & Executive Summary
This Technical Design Document (TDD) serves as the definitive architectural blueprint for the Power BI semantic model. It provides a comprehensive overview of the data engineering lifecycle, from structural modeling to analytical logic implementation. The primary objective is to ensure institutional data governance, facilitate scalable maintenance, and provide a single source of truth for business-critical KPIs.

* **Project Scope:** [Infer based on report name - e.g., Global Performance Analytics]
* **Report Name:** [ReportName from Metadata]
* **Technical Authority:** Data Architecture & BI Excellence Team
* **Target Audience:** Strategic Stakeholders, Data Stewards, and Lead Developers

## 2. Data Sources & Architecture
The model is built upon a resilient data integration layer, optimized for high-performance analytical querying.
* **Upstream Systems:** Multi-source integration (SQL Server, Cloud Repositories, Flat Files).
* **Storage Engine:** VertiPaq (In-Memory) via Import Mode to maximize DAX performance.
* **Connectivity:** Enterprise Gateway / Service-to-Service refresh.
* **Refresh Frequency:** Standardized daily processing at 06:00 AM UTC.

## 3. Security & Governance
Strict adherence to enterprise data protection standards is enforced at the model level.
* **Access Control:** Role-Based Access Control (RBAC) via Power BI Workspace permissions.
* **Row-Level Security (RLS):** Dynamic security predicates implemented via DAX filters based on organizational hierarchy.
* **Data Classification:** [Highly Confidential / Internal] - Access restricted to authorized personnel.

## 4. Semantic Model & Report Design

### 4.2 Data Model
#### 4.2.1 Star Schema Architecture
The semantic model utilizes a dimensional star-schema architecture, following Kimball methodology where applicable. This design decouples transactional fact events from descriptive master data (dimensions), ensuring optimal compression and sub-second query response times for complex aggregations.

**Fact Tables (Central & Specialized)**
| Fact Table Name | Purpose | Key Characteristics |
|---|---|---|

**Dimension & Master Tables**
| Dimension/Master Table Name | Purpose | Key Characteristics |
|---|---|---|

**Relationship Model**
| Relationship (From -> To) | Cardinality | Active | Cross-Filter | Purpose |
|---|---|---|---|---|
 
### 4.3 Report Design
#### 4.3.3 Measures definition and organization
The analytical layer is structured into logical display folders to differentiate between base metrics, time-intelligence overrides, and UI-specific dynamic titles. This modularity ensures the model remains scalable for self-service reporting.

| Display Folder | Purpose | Example Measures |
|---|---|---|

**Measure Details by Logical Category**

#### [Measure Name]
**Business Logic:** [Detailed architectural explanation of the calculation and its business impact]
```dax
[DAX Code]
```
---

</document_structure>
 
<workflow_instructions>
Step 1: Read the `AccumulatedPBIPMetadata.txt` file.
Step 2: Generate the complete markdown file for each report following the <document_structure>.
Step 3: Tell me in the chat which reports have been documented.
</workflow_instructions>
 
<execution_trigger>
When I say "GENERATE ALL", begin the process.
</execution_trigger>