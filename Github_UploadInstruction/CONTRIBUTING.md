# Contributing to Power BI Documentation Generator

Gracias por tu interés en contribuir. 🙏 Las contribuciones de cualquier tamaño son bienvenidas.

## Cómo Contribuir

### 1. **Reportar Bugs**

Si encuentras un error, por favor abre un issue con:

```markdown
**Título:** [BUG] Descripción corta del problema

**Descripción:**
- Qué esperabas que pasara
- Qué pasó realmente
- Pasos para reproducir

**Entorno:**
- OS: Windows/macOS/Linux
- Python: 3.10 / 3.11 / 3.12
- Versión de Power BI

**Archivos:**
Adjunta el archivo .md o .pbip que causa el error (si es posible)
```

### 2. **Sugerir Mejoras**

Tienes una idea? Abre una **Discussion** o issue con:

```markdown
**Tipo:** Feature Request / Enhancement / Documentation

**Descripción:** 
Explica brevemente qué mejora y por qué sería útil

**Ejemplo de Uso:**
[Muestra cómo se vería la mejora en práctica]
```

### 3. **Contribuir Código**

#### Fork, Branch, Pull Request

```bash
# 1. Fork el repositorio en GitHub (botón en arriba a la derecha)

# 2. Clona tu fork
git clone https://github.com/TU_USUARIO/power-bi-docs-generator.git
cd power-bi-docs-generator

# 3. Crea una rama para tu feature
git checkout -b feature/tu-feature-name
# O para bugs:
git checkout -b fix/tu-bug-name

# 4. Haz cambios y commits
git add .
git commit -m "feat: description of what you did"

# 5. Push a tu fork
git push origin feature/tu-feature-name

# 6. Abre un Pull Request en GitHub
# (Verás el botón "Compare & Pull Request")
```

#### Convenciones de Commits

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: add new feature
fix: resolve bug
docs: update documentation
style: formatting, missing semicolons, etc
refactor: code restructuring without functionality change
perf: performance improvements
test: add/update tests
chore: dependencies, build tools, etc
```

**Ejemplos:**
```bash
git commit -m "feat: add Mermaid diagram generation for relationships"
git commit -m "fix: resolve PDF export encoding issue on Windows"
git commit -m "docs: add Setup Guide"
```

### 4. **Mejorar Documentación**

- Typos en README, SETUP.md, etc
- Ejemplos más claros
- Mejor explicación de conceptos

Simplemente abre un PR con tus cambios. 📝

---

## Standards y Best Practices

### Código Python

```python
# ✅ DO: Clear, documented code
def extract_pbip_metadata(pbip_path: str) -> dict:
    """
    Extracts metadata from Power BI project.
    
    Args:
        pbip_path: Absolute path to .pbip project folder
        
    Returns:
        Dictionary with tables, columns, measures, relationships
        
    Raises:
        FileNotFoundError: If project path doesn't exist
    """
    if not os.path.exists(pbip_path):
        raise FileNotFoundError(f"Project not found: {pbip_path}")
    
    # Implementation...
    return metadata

# ❌ DON'T: Unclear code without docs
def extract(p):
    m = {}
    # Do stuff
    return m
```

### Error Handling

```python
# ✅ DO: Specific exceptions
try:
    doc = Document(docx_path)
except FileNotFoundError:
    print(f"Error: Word template not found at {docx_path}")
    sys.exit(1)
except Exception as e:
    traceback.print_exc()
    raise

# ❌ DON'T: Generic exception handling
try:
    # code
except:
    pass
```

### Testing

Si añades una feature, por favor incluye un test:

```python
def test_extract_metadata_valid_project():
    metadata = extract_pbip_metadata("path/to/test/project")
    assert "tables" in metadata
    assert "measures" in metadata
    assert len(metadata["tables"]) > 0
```

---

## Código de Conducta

### Nuestro Compromiso

Nos comprometemos a proporcionar un ambiente inclusivo y respetuoso.

### Comportamiento Esperado

✅ Use lenguaje acogedor e inclusivo  
✅ Respete opiniones y experiencias diferentes  
✅ Acepte crítica constructiva  
✅ Enfóquese en lo que es mejor para la comunidad  

### Comportamiento No Aceptable

❌ Lenguaje o imágenes sexuales  
❌ Ataques personales  
❌ Trolling o comentarios hirientes  
❌ Acoso público o privado  

---

## Áreas Donde Podemos Usar Ayuda

### 🔴 Alta Prioridad

- [ ] **Diagrama automático de relaciones** — Convertir estructura JSON a Mermaid/Visio
- [ ] **Validación de medidas** — Detectar medidas sin documentación
- [ ] **Soporte multi-lenguaje** — Generar docs en ES/EN/FR/DE

### 🟡 Media Prioridad

- [ ] **Integración Git** — Auto-regenerar docs en cada commit
- [ ] **Reportes de impacto** — Análisis de medidas rotas en producción
- [ ] **Tests automatizados** — Aumentar cobertura de tests

### 🟢 Baja Prioridad

- [ ] **Soporte para Looker/Tableau** — Extensión a otras herramientas BI
- [ ] **Dashboard HTML** — Versión interactiva de la documentación
- [ ] **CLI mejorada** — Comandos adicionales y opciones

---

## Preguntas?

- 💬 Abre una **Discussion** en GitHub
- 📧 Contacta a [maintainer-email@example.com]
- 🐦 Menciona [@maintainer-twitter]

---

## Gracias por Contribuir! 🎉

Tu contribución es valiosa, no importa qué tan pequeña sea. ¡Esperamos trabajar contigo!

**Last updated:** May 2026
