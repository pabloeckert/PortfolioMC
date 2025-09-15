#!/bin/bash
# Ejecutar desde el raíz del proyecto

# 1. Clases principales
find . -type f -name "*.php" -exec sed -i 's/Photonic_Flickr_Processor/PortfolioMC_FlickrPlatform/g' {} +
find . -type f -name "*.php" -exec sed -i 's/Photonic_Flickr_Options/PortfolioMC_FlickrOptions/g' {} +

# 2. Funciones globales
find . -type f -name "*.php" -exec sed -i 's/Photonic_Flickr_/PortfolioMC_Flickr_/g' {} +

# 3. Mensaje de éxito
echo "✔️ Reemplazo completado. Revisa los cambios con git diff antes de hacer commit."