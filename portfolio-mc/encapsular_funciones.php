<?php
/**
 * Script para automatizar el encapsulamiento de funciones globales PortfolioMC_Flickr_
 * dentro de la clase PortfolioMC_FlickrPlatform en FlickrPlatform.php
 *
 * Uso:
 *   php encapsular_funciones.php /ruta/a/FlickrPlatform.php
 */

if ($argc < 2) {
    echo "Uso: php encapsular_funciones.php /ruta/a/FlickrPlatform.php\n";
    exit(1);
}

$filename = $argv[1];
$code = file_get_contents($filename);

if ($code === false) {
    echo "No se pudo leer el archivo $filename\n";
    exit(1);
}

// 1. Detectar y extraer todas las funciones globales PortfolioMC_Flickr_*
$pattern = '/function\s+PortfolioMC_Flickr_([a-zA-Z0-9_]+)\s*\((.*?)\)\s*\{([\s\S]*?)\n\}/m';

$matches = [];
preg_match_all($pattern, $code, $matches, PREG_SET_ORDER);

if (empty($matches)) {
    echo "No se encontraron funciones globales PortfolioMC_Flickr_ en $filename\n";
    exit(0);
}

// 2. Preparar los métodos para la clase
$methods = "";
foreach ($matches as $match) {
    $func_name = $match[1];
    $params = $match[2];
    $body = $match[3];

    // Opcional: Puedes intentar reemplazar variables globales por $this->variable aquí
    $methods .= "\n    public function $func_name($params){{$body}\n    }\n";
}

// 3. Eliminar las funciones globales originales del archivo
$code = preg_replace($pattern, '', $code);

// 4. Insertar los métodos en la clase PortfolioMC_FlickrPlatform
$pattern_class = '/class\s+PortfolioMC_FlickrPlatform\s*\{([\s\S]*?)\}/m';

if (preg_match($pattern_class, $code, $class_match, PREG_OFFSET_CAPTURE)) {
    $class_start = $class_match[0][1];
    $class_body   = $class_match[1][0];

    // Insertar los métodos al final del cuerpo de la clase
    $new_body = $class_body . $methods;

    // Reemplazar el cuerpo de la clase en el código original
    $code = preg_replace($pattern_class, "class PortfolioMC_FlickrPlatform {\n$new_body\n}", $code, 1);
} else {
    // Si no se encuentra la clase, mostrar advertencia
    echo "No se encontró la clase PortfolioMC_FlickrPlatform en $filename\n";
    exit(1);
}

// 5. Guardar el archivo modificado (haz backup primero)
$backup = $filename . '.bak';
copy($filename, $backup);
file_put_contents($filename, $code);

echo "✔️ Funciones encapsuladas en la clase PortfolioMC_FlickrPlatform.\n";
echo "Backup creado en $backup\n";