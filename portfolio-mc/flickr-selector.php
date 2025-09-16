<?php
/**
 * Visualizador de colecciones Flickr con semáforo de diagnóstico
 * Requiere clase PortfolioMC_FlickrPlatform disponible en el entorno
 */

$api_key = 'c0d9ee4c756e3e6bc0bc8d4a5045d685';
$user_id = '24886685@N06';

function get_collections($api_key, $user_id) {
    $url = "https://api.flickr.com/services/rest/?method=flickr.collections.getTree&api_key=$api_key&user_id=$user_id&format=json&nojsoncallback=1";
    $response = json_decode(file_get_contents($url), true);
    return $response['collections']['collection'] ?? [];
}

function get_albums($api_key, $user_id) {
    $url = "https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=$api_key&user_id=$user_id&format=json&nojsoncallback=1";
    $response = json_decode(file_get_contents($url), true);
    $albums = [];
    foreach ($response['photosets']['photoset'] ?? [] as $set) {
        $albums[$set['id']] = $set['title']['_content'];
    }
    return $albums;
}

$collections = get_collections($api_key, $user_id);
$albums = get_albums($api_key, $user_id);
?>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Selector Flickr PortfolioMC</title>
  <style>
    body { font-family: sans-serif; padding: 20px; }
    .collection { margin-bottom: 20px; }
    .album { margin-left: 20px; }
    .apply-btn { margin-top: 20px; }
    .status { margin-top: 30px; font-size: 18px; font-weight: bold; }
    .green { color: #2e7d32; }
    .yellow { color: #f9a825; }
    .red { color: #c62828; }
  </style>
</head>
<body>
  <h2>📁 Colecciones Flickr</h2>
  <form method="post">
    <?php foreach ($collections as $collection): ?>
      <div class="collection">
        <strong><?php echo htmlspecialchars($collection['title']); ?></strong>
        <?php foreach ($collection['set'] ?? [] as $set): ?>
          <?php if (isset($albums[$set['id']])): ?>
            <div class="album">
              <label>
                <input type="radio" name="selected_album" value="<?php echo $set['id']; ?>">
                <?php echo htmlspecialchars($albums[$set['id']]); ?>
              </label>
            </div>
          <?php endif; ?>
        <?php endforeach; ?>
      </div>
    <?php endforeach; ?>
    <button type="submit" class="apply-btn">Aplicar</button>
  </form>

  <?php
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['selected_album'])) {
      $album_id = $_POST['selected_album'];
      echo "<div class='status'>🔍 Probando álbum ID: $album_id<br>";

      if (class_exists('PortfolioMC_FlickrPlatform')) {
          $motor = new PortfolioMC_FlickrPlatform();
          $photos = $motor->get_album($album_id);

          if (is_array($photos) && count($photos) > 0) {
              echo "<span class='green'>✅ Álbum cargado correctamente. Se encontraron " . count($photos) . " fotos.</span>";
          } elseif (is_array($photos) && count($photos) === 0) {
              echo "<span class='yellow'>⚠️ Álbum vacío. No se encontraron fotos.</span>";
          } else {
              echo "<span class='red'>❌ Error al cargar el álbum. Respuesta inválida.</span>";
          }
      } else {
          echo "<span class='red'>❌ Clase PortfolioMC_FlickrPlatform no disponible.</span>";
      }

      echo "</div>";
  }
  ?>
</body>
</html>
