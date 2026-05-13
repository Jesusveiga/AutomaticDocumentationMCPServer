# 🚀 PUSH A GITHUB EN 5 MINUTOS

## Opción 1️⃣: Automático (Recomendado)

Abre PowerShell en esta carpeta y ejecuta:

```powershell
.\push-to-github.ps1 `
    -RepositoryURL "https://github.com/TU_USUARIO/power-bi-docs-generator.git" `
    -UserName "Tu Nombre Completo" `
    -UserEmail "tu.email@gmail.com"
```

**Reemplaza:**
- `TU_USUARIO` → tu usuario de GitHub
- `Tu Nombre Completo` → tu nombre real
- `tu.email@gmail.com` → tu email GitHub

**El script automáticamente:**
✅ Inicializa git  
✅ Configura tu usuario  
✅ Añade todos los archivos  
✅ Crea el commit inicial  
✅ Configura el remote  
✅ Sube todo a GitHub  

---

## Opción 2️⃣: Manual (3 Comandos)

Si prefieres hacerlo manualmente en PowerShell:

```powershell
# 1. Configura git (una sola vez)
git config --global user.name "Tu Nombre"
git config --global user.email "tu.email@gmail.com"

# 2. Prepara y sube
git add .
git commit -m "✨ feat: Power BI Documentation Automation System - Initial Release"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/power-bi-docs-generator.git
git push -u origin main
```

---

## ⚠️ Primer Push? Necesitarás un Token

GitHub ya no acepta contraseña simple. Necesitas un **Personal Access Token**.

### Cómo Conseguirlo (2 minutos):

1. **Ve a:** https://github.com/settings/tokens
2. **Haz click:** "Generate new token (classic)"
3. **Nombre:** `PowerBI-Git-Token`
4. **Selecciona:** 
   - ☑️ repo (acceso completo a repos)
   - ☑️ read:user (lee perfil)
5. **Genera token** y **cópialo inmediatamente**
6. **Cuando Git pida password:** Pega el token

---

## 🎨 Después: Haz que se Vea Bonito

### Agrega un Badge al README

En la línea 3 de `README.md`, añade después del título:

```markdown
# 📋 Automatic Power BI Documentation Generator

![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![GitHub stars](https://img.shields.io/github/stars/yourusername/power-bi-docs-generator?style=social)

> **Transform Hours of Manual Documentation into Minutes of Automated Perfection**
```

Luego:
```powershell
git add README.md
git commit -m "docs: add badges to README"
git push
```

---

## ✅ Verificación

Abre GitHub y verifica:

- [ ] Todos tus archivos visibles
- [ ] README mostrándose formateado
- [ ] Verde "main" en la rama
- [ ] Commits visibles en el historial

---

## 🎯 Checklist Final

```
Antes de compartir:

❌ ¿Hay archivos .docx o .pdf? → NO (están en .gitignore)
❌ ¿Hay carpeta .venv? → NO (está en .gitignore)
✅ ¿README.md existe? → SÍ
✅ ¿CONTRIBUTING.md existe? → SÍ
✅ ¿requirements.txt está actualizado? → SÍ
✅ ¿.gitignore está configurado? → SÍ
```

---

## 🚨 Si Algo Sale Mal

### "Permission denied"
```powershell
# Usa tu token en lugar de contraseña
# O instala Git Credential Manager:
# https://github.com/git-ecosystem/git-credential-manager
```

### "Repository already exists"
```powershell
# Asegúrate de que creaste el repo en GitHub ANTES de hacer push
# Ve a https://github.com/new
```

### "The requested URL returned error: 403"
```powershell
# Token expirado o sin permisos
# Genera uno nuevo siguiendo "Cómo Conseguirlo" arriba
```

---

## 🎉 ¡LISTO!

Una vez empujado:

1. **Comparte en Twitter:**
   > Acabo de publicar en GitHub mi herramienta para automatizar documentación en Power BI usando MCP. Genera docs profesionales en 3 minutos! 🚀 #DataEngineering #PowerBI #OpenSource

2. **Comparte en LinkedIn:**
   > Excited to share our Power BI Documentation Generator - an automated tool that transforms documentation from hours of manual work to just 3 minutes. Check it out! 

3. **Comparte el link:**
   ```
   https://github.com/TU_USUARIO/power-bi-docs-generator
   ```

---

**¿Necesitas ayuda?** Abre un issue en GitHub o contacta al maintainer.

Buena suerte! 🎊
