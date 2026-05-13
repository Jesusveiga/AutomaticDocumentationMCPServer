# 📁 ESTRUCTURA DEL PROYECTO

## Antes de Empezar: Ejecuta la Limpieza

```powershell
# En PowerShell, en esta carpeta:
.\cleanup.ps1
```

Esto automáticamente:
- ✅ Organiza archivos en carpetas
- ✅ Elimina archivos innecesarios  
- ✅ Prepara estructura para GitHub

---

## Estructura Final (Después de Limpieza)

```
power-bi-docs-generator/

📖 DOCUMENTACIÓN (Raíz)
├── README.md                          ← ⭐ Landing page (lee primero)
├── CONTRIBUTING.md                    ← Guía para contribuidores
├── CHANGELOG.md                       ← Historial de versiones
├── LICENSE                            ← MIT License
├── START_HERE.md                      ← Resumen ejecutivo
├── QUICK_PUSH.md                      ← Guía rápida GitHub
├── GITHUB_SETUP.md                    ← Detalles técnicos
├── FINAL_CHECKLIST.md                 ← Checklist pre-launch
├── MEDIUM_ARTICLE_DRAFT.md            ← Artículo listo para publicar

🐍 CÓDIGO (Raíz)
├── AutomaticDocumentation.py          ← Core: extracción de metadatos
├── ConvertToPdf.py                    ← Pipeline: MD → DOCX → PDF
├── semiautomatic_prompt.md            ← Templates y estructura doc
├── requirements.txt                   ← Python dependencies
├── push-to-github.ps1                 ← Script para subir a GitHub
├── cleanup.ps1                        ← Script de limpieza/organización

🔧 TEMPLATES
templates/
└── Professional_Template.docx         ← Template Word corporativo

📊 EJEMPLOS & SALIDAS
examples/
├── TechnicalDesign_EmailCommunication_DummyReport.md     ← Output Markdown
├── TechnicalDesign_EmailCommunication_DummyReport.docx   ← Output Word
├── TechnicalDesign_EmailCommunication_DummyReport.pdf    ← Output PDF
└── AccumulatedPBIPMetadata.txt        ← Metadata example JSON

🛠️ SCRIPTS AUXILIARES
scripts/
└── generar_plantilla.py               ← Helper scripts (opcional)

🖼️ ASSETS (Para documentación visual)
assets/
└── (imágenes, screenshots, diagramas)

⚡ PROYECTOS POWER BI
├── EmailCommunication_DummyReport.pbip/          ← Proyecto Power BI
├── EmailCommunication_DummyReport.Report/        ← Reportes
└── EmailCommunication_DummyReport.SemanticModel/ ← Modelo semántico

🔒 GIT
├── .gitignore                         ← Ignora .venv, *.docx, etc
└── .git/                              ← Repositorio git
```

---

## Qué Va Dónde

### 📖 En RAÍZ (Directorio Principal)
- Todos los `.md` de documentación (README, CONTRIBUTING, etc)
- Archivos `requirements.txt` y `LICENSE`
- Scripts principales: `AutomaticDocumentation.py`, `ConvertToPdf.py`
- Scripts de utilidad: `push-to-github.ps1`, `cleanup.ps1`

**Por qué?** GitHub muestra estos archivos en el landing page.

### 🔧 `/templates`
- `Professional_Template.docx` ← Template Word profesional
- Cualquier otro template de documento

**Por qué?** Mantiene ordenado y reutilizable.

### 📊 `/examples`
- Archivos generados (`.docx`, `.pdf`)
- Metadata de ejemplo (`AccumulatedPBIPMetadata.txt`)
- Archivos `.md` de demostración

**Por qué?** Muestra exactamente qué produce tu herramienta.

### 🛠️ `/scripts`
- Scripts auxiliares como `generar_plantilla.py`
- Helpers adicionales

**Por qué?** Scripts no principales, mantiene limpio.

### 🖼️ `/assets`
- Imágenes/screenshots para documentación
- Diagramas
- Logos

**Por qué?** Organiza recursos visuales.

---

## 🎯 Lo que GITHUB verá

Cuando alguien visite tu repo:

```
✅ README.md (automáticamente renderizado)
✅ Código Python principal visible
✅ Todos los .md de docs
✅ LICENSE visible
✅ Carpetas organizadas (templates, examples, etc)

❌ No ve .docx/.pdf (están en /examples)
❌ No ve .venv (está en .gitignore)
❌ No ve instaladores MSI
```

---

## 📋 Checklist: ¿Está Limpio?

Después de ejecutar `cleanup.ps1`:

```
EN RAÍZ:
☑️ Solo archivos .md y .py principales
☑️ No hay archivos .docx duplicados
☑️ No hay pandoc-xxx.msi
☑️ No hay archivos temporales (~$...)

CARPETAS:
☑️ /templates contiene Professional_Template.docx
☑️ /examples contiene outputs (.docx, .pdf)
☑️ /scripts contiene helpers
☑️ /assets está vacío (listo para tus imágenes)

IGNORADOS:
☑️ .venv/ está en .gitignore (no sube)
☑️ *.pdf está en .gitignore (optional)
☑️ *.docx está en .gitignore (solo template en /templates)
```

---

## 🚀 El Flujo Final

```
1. Ejecutas cleanup.ps1
   ↓
2. Estructura se organiza automáticamente
   ↓
3. Ejecutas push-to-github.ps1
   ↓
4. ¡Todo está en GitHub limpio y profesional!
```

---

## 🎨 Antes vs Después

### ❌ ANTES (Desorden)
```
root/
├── .gitignore
├── AutomaticDocumentation.py
├── generar_plantilla.py                    ← Mezclado
├── ConvertToPdf.py
├── Professional_Template.docx              ← Mezclado
├── My_Professional_Template.docx           ← Duplicado
├── pandoc-3.9.0.2-windows-x86_64.msi      ← Innecesario
├── TechnicalDesign_EmailCommunication...docx  ← Ejemplos mezclados
├── TechnicalDesign_EmailCommunication...pdf   ← Ejemplos mezclados
├── ~$echnicalDesign_...docx                ← Temporal de Word
├── SDG Group - BOEHRINGER...docx           ← Viejo, otro proyecto
├── AccumulatedPBIPMetadata.txt             ← Metadata mezclada
├── README.md
├── CONTRIBUTING.md
└── ... otros 10 archivos
```

**Total: 30+ archivos en la raíz. ¡Caos!**

### ✅ DESPUÉS (Limpio)
```
root/
├── 📖 README.md
├── 🤝 CONTRIBUTING.md
├── 📋 CHANGELOG.md
├── 🔒 LICENSE
├── 📌 START_HERE.md
├── ⚡ QUICK_PUSH.md
├── 📚 GITHUB_SETUP.md
├── ✅ FINAL_CHECKLIST.md
├── 📰 MEDIUM_ARTICLE_DRAFT.md
├── 🐍 AutomaticDocumentation.py
├── 🐍 ConvertToPdf.py
├── semiautomatic_prompt.md
├── requirements.txt
├── push-to-github.ps1
├── cleanup.ps1
│
├── 🔧 templates/
│   └── Professional_Template.docx
├── 📊 examples/
│   ├── TechnicalDesign_EmailCommunication_DummyReport.md
│   ├── TechnicalDesign_EmailCommunication_DummyReport.docx
│   ├── TechnicalDesign_EmailCommunication_DummyReport.pdf
│   └── AccumulatedPBIPMetadata.txt
├── 🛠️ scripts/
│   └── generar_plantilla.py
├── 🖼️ assets/
└── ⚡ EmailCommunication_DummyReport.*/
```

**Total: 15 archivos en raíz, resto en carpetas. ¡Profesional!**

---

## 📊 Qué Ve GitHub

### En el Navegador (Landing Page):
```
power-bi-docs-generator
    
[Description from settings]

📖 README.md (renderizado automáticamente)

📁 Carpetas:
   • assets/
   • examples/
   • scripts/
   • templates/

📄 Archivos:
   • AutomaticDocumentation.py
   • ConvertToPdf.py
   • CONTRIBUTING.md
   • LICENSE
   • ... (resto de .md)
```

---

## ✨ Ventajas de Esta Estructura

1. **Profesional** — Parece un proyecto serio
2. **Organizado** — Todo en su lugar
3. **Fácil Navegar** — Los usuarios encuentran lo que necesitan
4. **GitHub Friendly** — Muestra bien en la plataforma
5. **Ejemplos Claros** — `/examples` muestra exactamente qué hace
6. **Reutilizable** — Templates en `/templates`, helpers en `/scripts`

---

## 🎯 Próximo Paso

```powershell
# Ejecuta en PowerShell (en la carpeta del proyecto):
.\cleanup.ps1

# Espera a que termine (toma 10-15 segundos)

# Verifica la estructura:
Get-ChildItem -Recurse -Force | Select-Object FullName | Format-List
```

---

**Una vez limpio, ejecuta: `.\push-to-github.ps1` para subir a GitHub**

---

*Created: May 2026*
