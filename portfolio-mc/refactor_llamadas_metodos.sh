#!/bin/bash
# Refactoriza llamadas globales PortfolioMC_Flickr_funcion(...) a $motor->funcion(...)

# Cambia esta variable si tu código está en otra carpeta
CODE_PATH="."

# Prefijo de las funciones a reemplazar
PREFIX="PortfolioMC_Flickr_"

# Archivos PHP a modificar
find "$CODE_PATH" -type f -name "*.php" | while read archivo; do
    cp "$archivo" "$archivo.bak"
    # Reemplaza llamadas a PortfolioMC_Flickr_funcion( ... ) por $motor->funcion( ... )
    sed -E -i "s/${PREFIX}([a-zA-Z0-9_]+)[[:space:]]*\(/\\\$motor->\1(/g" "$archivo"
done

echo "✔️ Reemplazo automático completado. Se crearon backups .bak de cada archivo PHP modificado."
echo "Recordá crear la instancia \$motor = new PortfolioMC_FlickrPlatform(); donde sea necesario."