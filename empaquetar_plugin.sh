#!/bin/bash

PLUGIN_DIR="portfolio-mc"
ZIP_FILE="portfolio-mc.zip"

echo "📦 Iniciando empaquetado del plugin PortfolioMC..."

# 1. Verificar que la carpeta exista
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "❌ Carpeta '$PLUGIN_DIR/' no encontrada. Abortando."
  exit 1
fi

# 2. Eliminar zip previo si existe
if [ -f "$ZIP_FILE" ]; then
  echo "🧹 Eliminando archivo zip previo..."
  rm -v "$ZIP_FILE"
fi

# 3. Crear nuevo zip excluyendo carpetas y archivos innecesarios
echo "🗜️ Comprimiendo carpeta '$PLUGIN_DIR/'..."
zip -r "$ZIP_FILE" "$PLUGIN_DIR" \
  -x "$PLUGIN_DIR/.git/*" \
  -x "$PLUGIN_DIR/.gitignore" \
  -x "$PLUGIN_DIR/tools/*" \
  -x "$PLUGIN_DIR/*.bak" \
  -x "$PLUGIN_DIR/**/*.bak" \
  -x "*/.DS_Store" > /dev/null

# 4. Confirmar resultado
if [ -f "$ZIP_FILE" ]; then
  echo "✅ Plugin empaquetado exitosamente: $ZIP_FILE"
else
  echo "❌ Error al crear el archivo zip."
fi
