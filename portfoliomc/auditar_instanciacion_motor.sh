#!/bin/bash

echo "📊 Auditoría de instanciación \$motor en archivos PHP..."

find . -type f -name "*.php" | while read file; do
    motor_calls=$(grep -c '\$motor->' "$file")
    motor_inst=$(grep -c '\$motor\s*=\s*new\s*PortfolioMC_FlickrPlatform' "$file")

    if [ "$motor_calls" -gt 0 ]; then
        if [ "$motor_inst" -eq 0 ]; then
            echo "⚠️ Falta instanciación en: $file (usa \$motor-> pero no lo crea)"
        elif [ "$motor_inst" -gt 1 ]; then
            echo "🟡 Duplicación posible en: $file ($motor_inst instancias)"
        else
            echo "✅ Correcto en: $file"
        fi
    fi
done

echo "✔️ Auditoría completada."
