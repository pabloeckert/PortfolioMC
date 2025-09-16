#!/bin/bash

echo "🔧 Preparando estructura base del plugin PortfolioMC..."

# 1. Crear archivo principal si no existe
if [ ! -f "portfolio-mc.php" ]; then
  echo "🧾 Creando portfolio-mc.php..."
  cat <<'EOL' > portfolio-mc.php
<?php
/*
Plugin Name: Portfolio MC
Description: Motor Flickr encapsulado con layout visual y selector de álbumes.
Version: 1.0
Author: Pablo Eckert
*/

require_once plugin_dir_path(__FILE__) . 'engine/flickr/FlickrPlatform.php';
require_once plugin_dir_path(__FILE__) . 'engine/flickr/FlickrOptions.php';
EOL
else
  echo "✅ portfolio-mc.php ya existe."
fi

# 2. Crear carpetas faltantes
for dir in includes assets assets/css; do
  if [ ! -d "$dir" ]; then
    echo "📁 Creando carpeta: $dir"
    mkdir -p "$dir"
  else
    echo "✅ Carpeta '$dir/' ya existe."
  fi
done

echo "✔️ Estructura base lista. Podés continuar con el empaquetado."
