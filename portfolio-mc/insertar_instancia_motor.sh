#!/bin/bash
# Inserta $motor = new PortfolioMC_FlickrPlatform(); automáticamente donde se detecta uso de $motor->

CODE_PATH="." # Cambia si tu código está en otra carpeta

find "$CODE_PATH" -type f -name "*.php" | while read archivo; do
    # Detectar si hay uso de $motor->
    if grep -q '\$motor->' "$archivo"; then
        # ¿Ya existe la instancia?
        if ! grep -q '\$motor[ ]*=[ ]*new[ ]*PortfolioMC_FlickrPlatform' "$archivo"; then
            cp "$archivo" "$archivo.bak"
            # Insertar después del primer <?php o en la primera línea si no existe
            awk '
            BEGIN {inserted=0}
            /^<\?php/ && !inserted {
                print $0
                print ""
                print "$motor = new PortfolioMC_FlickrPlatform();"
                print ""
                inserted=1
                next
            }
            {print $0}
            END {
                if (!inserted) {
                    print ""
                    print "$motor = new PortfolioMC_FlickrPlatform();"
                }
            }
            ' "$archivo.bak" > "$archivo"
            echo "✔️ Instancia de \$motor insertada en $archivo"
        fi
    fi
done

echo "Script finalizado. Respaldos en *.bak"