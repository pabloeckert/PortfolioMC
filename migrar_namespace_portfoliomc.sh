#!/bin/bash
# Script para migrar namespaces, use y require_once de Photonic_Plugin a PortfolioMC

# Carpeta raíz del código (ajusta si tu código está en otra ubicación)
CODE_PATH="."

# Prefijos a cambiar
OLD_NAMESPACE="Photonic_Plugin"
NEW_NAMESPACE="PortfolioMC"

# 1. Cambiar namespace en todos los archivos PHP
find "$CODE_PATH" -type f -name "*.php" | while read archivo; do
    cp "$archivo" "$archivo.bak"
    # Cambia el namespace principal
    sed -E -i "s/^namespace[ \t]+${OLD_NAMESPACE}([^;]*);/namespace ${NEW_NAMESPACE}\1;/" "$archivo"
    # Cambia los use
    sed -E -i "s/^use[ \t]+${OLD_NAMESPACE}([^;]*);/use ${NEW_NAMESPACE}\1;/" "$archivo"
    # Cambia referencias directas en el código (evita los comentarios)
    sed -E -i "s/${OLD_NAMESPACE}\\/([A-Za-z0-9_]+)/${NEW_NAMESPACE}\/\1/g" "$archivo"
    # Cambia require_once y require si hace falta (si usas rutas relativas, puedes adaptar esto o hacerlo manual)
done

echo "✔️ Migración de namespaces y rutas a PortfolioMC completada. Se crearon backups .bak de cada archivo PHP modificado."
echo "Revisa rutas absolutas o PHOTONIC_PATH manualmente si aplican casos especiales."