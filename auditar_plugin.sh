#!/bin/bash

PLUGIN_DIR="portfolio-mc"
OUTPUT_FILE="diagnostico_portfolio_mc.txt"

echo "🧠 Iniciando auditoría integral del plugin '$PLUGIN_DIR'..." | tee "$OUTPUT_FILE"
echo "============================================================" | tee -a "$OUTPUT_FILE"

# 1️⃣ Verificar estructura base
echo "🔍 Verificando estructura de archivos y carpetas..." | tee -a "$OUTPUT_FILE"
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "❌ Carpeta '$PLUGIN_DIR/' no encontrada. Abortando." | tee -a "$OUTPUT_FILE"
  exit 1
fi

MAIN_FILE="$PLUGIN_DIR/portfolio-mc.php"
if [ ! -f "$MAIN_FILE" ]; then
  echo "❌ Archivo principal 'portfolio-mc.php' no encontrado." | tee -a "$OUTPUT_FILE"
else
  echo "📄 Headers encontrados en '$MAIN_FILE':" | tee -a "$OUTPUT_FILE"
  grep -E "Plugin Name|Description|Version|Author" "$MAIN_FILE" | tee -a "$OUTPUT_FILE"
fi

for dir in engine includes assets; do
  if [ -d "$PLUGIN_DIR/$dir" ]; then
    echo "✅ Carpeta '$dir/' encontrada." | tee -a "$OUTPUT_FILE"
  else
    echo "⚠️ Carpeta '$dir/' no encontrada." | tee -a "$OUTPUT_FILE"
  fi
done
echo "------------------------------------------------------------" | tee -a "$OUTPUT_FILE"

# 2️⃣ Verificar sintaxis PHP
echo "🧪 Analizando sintaxis PHP..." | tee -a "$OUTPUT_FILE"
SYNTAX_ERRORS=0
while read -r file; do
  errors=$(php -l "$file" 2>&1 | grep -v "No syntax errors detected")
  if [ -n "$errors" ]; then
    echo "🚨 Error de sintaxis en: $file" | tee -a "$OUTPUT_FILE"
    echo "$errors" | tee -a "$OUTPUT_FILE"
    SYNTAX_ERRORS=1
  fi
done < <(find "$PLUGIN_DIR" -type f -name "*.php")

if [ "$SYNTAX_ERRORS" -eq 0 ]; then
  echo "✅ Todos los archivos PHP tienen sintaxis válida." | tee -a "$OUTPUT_FILE"
fi
echo "------------------------------------------------------------" | tee -a "$OUTPUT_FILE"

# 3️⃣ Verificar codificación de archivos
echo "🔤 Verificando codificación de archivos..." | tee -a "$OUTPUT_FILE"
find "$PLUGIN_DIR" -type f | while read -r file; do
  encoding=$(file -b --mime-encoding "$file")
  echo "📁 $file → Codificación: $encoding" | tee -a "$OUTPUT_FILE"
done
echo "------------------------------------------------------------" | tee -a "$OUTPUT_FILE"

# 4️⃣ Detectar puntos de entrada
echo "🔎 Buscando hooks y shortcodes..." | tee -a "$OUTPUT_FILE"
grep -r -E "register_activation_hook|register_deactivation_hook|add_action|add_shortcode|init" "$PLUGIN_DIR" | tee -a "$OUTPUT_FILE"
echo "------------------------------------------------------------" | tee -a "$OUTPUT_FILE"

# 5️⃣ Verificar dependencias internas
echo "📦 Analizando inclusiones de archivos..." | tee -a "$OUTPUT_FILE"
grep -r -E "require_once|include_once|require|include" "$PLUGIN_DIR" | tee -a "$OUTPUT_FILE"
echo "------------------------------------------------------------" | tee -a "$OUTPUT_FILE"

echo "✔️ Auditoría completa. Informe guardado en '$OUTPUT_FILE'." | tee -a "$OUTPUT_FILE"
