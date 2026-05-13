# 🚀 Guía: Cómo Subir tu Proyecto a GitHub

Sigue estos pasos exactos para empujar tu proyecto al repositorio de GitHub que creaste.

---

## Paso 1: Prepara tu Repositorio Local

Abre PowerShell en tu carpeta del proyecto:

```powershell
cd C:\Users\jesus.veiga\Desktop\MCP Project
```

Verifica que Git está inicializado:

```powershell
git status
```

**Si ves un error** como `fatal: not a git repository`:
```powershell
git init
git config user.name "Tu Nombre"
git config user.email "tu.email@example.com"
```

---

## Paso 2: Añade Todos los Archivos

```powershell
# Ver qué archivos van a ser subidos
git status

# Añadir TODOS los cambios
git add .

# Verificar que todo está listo
git status
```

**Debería mostrar algo como:**
```
Changes to be committed:
    new file: README.md
    new file: CONTRIBUTING.md
    modified: MEDIUM_ARTICLE_DRAFT.md
    ...
```

---

## Paso 3: Crea tu Primer Commit

```powershell
git commit -m "feat: initial commit - Power BI documentation automation system"
```

O algo más creativo:
```powershell
git commit -m "✨ feat: Automated Power BI documentation generator with MCP integration"
```

---

## Paso 4: Conecta con tu Repositorio de GitHub

**Abre GitHub en tu navegador:**

1. Ve a tu repositorio recién creado
2. Busca el botón verde **"Code"**
3. Copia el URL HTTPS:
   ```
   https://github.com/TU_USUARIO/power-bi-docs-generator.git
   ```

**En PowerShell, establece el remote:**

```powershell
# Reemplaza con tu URL real
git remote add origin https://github.com/TU_USUARIO/power-bi-docs-generator.git

# Verifica que está configurado
git remote -v
```

Deberías ver:
```
origin  https://github.com/TU_USUARIO/power-bi-docs-generator.git (fetch)
origin  https://github.com/TU_USUARIO/power-bi-docs-generator.git (push)
```

---

## Paso 5: Sube Todo a GitHub

```powershell
# Renombra tu rama a 'main' (estándar moderno)
git branch -M main

# ¡Sube todo!
git push -u origin main
```

**Primera vez?** Git te pedirá autenticación. Tienes 2 opciones:

### Opción A: Personal Access Token (Recomendado)

1. En GitHub: **Settings → Developer settings → Personal access tokens → Tokens (classic)**
2. Haz click en **"Generate new token"**
3. Dale permisos: `repo`, `read:user`, `user:email`
4. Copia el token
5. En PowerShell, cuando pida password, pega el token

### Opción B: Autenticación SSH (Avanzado)

Si ya tienes SSH configurado en GitHub:

```powershell
# Cambia tu remote a SSH
git remote set-url origin git@github.com:TU_USUARIO/power-bi-docs-generator.git

# Luego haz push
git push -u origin main
```

---

## ✅ Verificación

Ve a tu repositorio en GitHub y deberías ver:

✅ Todos tus archivos listados  
✅ README.md mostrándose como descripción  
✅ Commits visibles en el historial  
✅ Green checkmark en los archivos  

---

## Después: Futuros Cambios

Una vez esté todo sincronizado, los siguientes cambios son más simples:

```powershell
# Haz cambios en tus archivos
# Luego:

git add .
git commit -m "fix: improved table formatting in PDF export"
git push
```

---

## 🎨 Mejora Visual (Opcional pero Importante)

### Agrega una Imagen/Logo en tu README

1. **Crea una carpeta `assets/`:**
```powershell
mkdir assets
```

2. **Añade una imagen** (ej: `assets/demo.png`)

3. **Referencia en README.md:**
```markdown
![Demo Screenshot](assets/demo.png)
```

### Agrega Badges (Esos iconitos profesionales)

Edita tu README.md y añade al inicio:

```markdown
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/yourusername/power-bi-docs-generator)](https://github.com/yourusername/power-bi-docs-generator)
```

---

## 📋 Estructura Final Recomendada

Antes de empujar, asegúrate de tener:

```
tu-repo/
├── README.md                  ✅
├── CONTRIBUTING.md            ✅
├── .gitignore                 ✅
├── requirements.txt           ✅
├── LICENSE                    (Opcional)
│
├── AutomaticDocumentation.py  ✅
├── ConvertToPdf.py            ✅
├── semiautomatic_prompt.md    ✅
│
├── MEDIUM_ARTICLE_DRAFT.md    ✅
├── TechnicalDesign_EmailCommunication_DummyReport.md ✅
│
├── templates/
│   └── Professional_Template.docx
│
├── assets/
│   └── (screenshots, diagrams, etc)
│
└── examples/
    └── (sample input/output)
```

---

## 🎯 Checklist Final

Antes de dar por terminado:

- [ ] `git status` muestra "nothing to commit"
- [ ] GitHub muestra todos tus archivos
- [ ] README se ve bonito (Markdown formateado correctamente)
- [ ] No hay archivos `.docx` o `.pdf` subidos (están en `.gitignore`)
- [ ] No hay carpeta `.venv` subida (también en `.gitignore`)
- [ ] Tienes al menos un commit visible

---

## Troubleshooting

### Error: "fatal: not a git repository"
```powershell
git init
git config user.name "Tu Nombre"
git config user.email "tu.email@example.com"
```

### Error: "Repository not found"
Verifica que el URL en `git remote -v` es correcto.

### Error: "Authentication failed"
Usa un **Personal Access Token** en lugar de contraseña.

### Los cambios no aparecen
Verifica con:
```powershell
git log --oneline -5  # Muestra últimos 5 commits
git status           # Muestra estado actual
```

---

## 🎉 ¡Listo!

Tu repositorio está en GitHub. Ahora:

1. **Comparte el link** en Twitter, LinkedIn, Medium
2. **Pide feedback** en las issues
3. **Continúa mejorando** con contributions de otros

---

**¿Necesitas ayuda?** Abre un issue en tu repo o contacta al maintainer.
