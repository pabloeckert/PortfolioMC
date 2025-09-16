#!/bin/bash

PLUGIN_DIR="portfolio-mc"
PHP_COMMAND="php" # Comando por defecto

echo "🧠 Iniciando diagnóstico INTELIGENTE para '$PLUGIN_DIR'..."
echo "------------------------------------------------------"

# --- BLOQUE DE AUTODETECCIÓN DE PHP ---
# Intenta encontrar PHP en ubicaciones comunes de Windows
POSSIBLE_PATHS=(
    "/c/xampp/php/php.exe"
    "/c/wamp64/bin/php/php*/php.exe" # Para WAMP
    "/c/laragon/bin/php/php*/php.exe" # Para Laragon
)

echo "1️⃣  Buscando el ejecutable de PHP..."
for path in "${POSSIBLE_PATHS[@]}"; do
    # Usamos ls para manejar wildcards (*) como en la ruta de WAMP/Laragon
    FOUND_PHP=$(ls $path 2>/dev/null | head -n 1)
    if [ -n "$FOUND_PHP" ]; then
        PHP_COMMAND="$FOUND_PHP"
        echo "✅ PHP encontrado en: $PHP_COMMAND"
        break
    fi
done

if [ "$PHP_COMMAND" == "php" ]; then
    echo "⚠️  No se pudo autodetectar PHP. Usando el comando 'php' por defecto."
    echo "   Si ves errores de 'command not found', necesitas configurar tu PATH manualmente."
fi
echo "------------------------------------------------------"
# --- FIN DEL BLOQUE ---

# 2. Análisis de sintaxis PHP (usando el comando encontrado)
echo "2️⃣  Analizando sintaxis PHP en busca de errores..."
SYNTAX_ERRORS=0
find "$PLUGIN_DIR" -type f -name "*.php" | while read -r file; do
  # Usamos la variable $PHP_COMMAND que ahora tiene la ruta completa si se encontró
  errors=$("$PHP_COMMAND" -l "$file" 2>&1 | grep -v "No syntax errors detected")
  if [ -n "$errors" ]; then
    echo "🚨 Error de Sintaxis en: $file"
    echo "$errors"
    SYNTAX_ERRORS=1
  fi
done
if [ "$SYNTAX_ERRORS" -eq 0 ]; then
    echo "✅ Ningún error de sintaxis encontrado."
fi
echo "------------------------------------------------------"

# (Aquí irían los demás pasos del diagnóstico como antes...)

echo "✔️ Diagnóstico completo."