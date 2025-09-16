#!/bin/bash

echo "🧼 Iniciando limpieza y verificación de PortfolioMC..."

# 1. Eliminar archivos innecesarios
echo "🧹 Eliminando backups y archivos ocultos..."
find . -type f \( -name "*.bak" -o -name ".DS_Store" -o -name "*.log" \) -exec rm -v {} \;

# 2. Verificar archivo principal
echo "🔍 Verificando archivo principal..."
if [ -f "portfolio-mc.php" ]; then
    if grep -q "Plugin Name:" portfolio-mc.php; then
        echo "✅ portfolio-mc.php encontrado y con headers válidos."
    else
        echo "⚠️ portfolio-mc.php existe pero le faltan los headers de WordPress."
    fi
else
    echo "❌ portfolio-mc.php no encontrado en la raíz."
fi

# 3. Verificar readme.txt
echo "📄 Verificando readme.txt..."
if [ -f "readme.txt" ]; then
    echo "✅ readme.txt presente."
else
    echo "⚠️ Falta readme.txt. Se recomienda incluirlo."
fi

# 4. Confirmar estructura crítica
echo "📁 Verificando carpetas clave..."
for dir in engine includes assets; do
    if [ -d "$dir" ]; then
        echo "✅ Carpeta '$dir/' encontrada."
    else
        echo "⚠️ Carpeta '$dir/' no encontrada."
    fi
done

echo "✔️ Limpieza y verificación completadas. Listo para empaquetar."
