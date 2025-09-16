<?php
/*
Plugin Name: Portfolio MC
Plugin URI: https://mejoraok.com/
Description: Galería visual personalizada con motor Flickr basado en Photonic.
Version: 1.0
Author: Pablo Eckert
Author URI: https://mejoraok.com/
License: GPLv2 or later
Text Domain: portfolio-mc
*/
namespace PortfolioMC;

use PortfolioMC\Core\Photonic;

class Photonic_Plugin {
	public function __construct() {
		if (!defined('PHOTONIC_VERSION')) {
			define('PHOTONIC_VERSION', '3.21');
		}

		define('PHOTONIC_PATH', __DIR__);

		if (!defined('PHOTONIC_URL')) {
			define('PHOTONIC_URL', plugin_dir_url(__FILE__));
		}

		$photonic_wp_upload_dir = wp_upload_dir();
		if (!defined('PHOTONIC_UPLOAD_DIR')) {
			define('PHOTONIC_UPLOAD_DIR', trailingslashit($photonic_wp_upload_dir['basedir']) . 'photonic');
		}

		if (!defined('PHOTONIC_UPLOAD_URL')) {
			define('PHOTONIC_UPLOAD_URL', trailingslashit($photonic_wp_upload_dir['baseurl']) . 'photonic');
		}

		require_once PHOTONIC_PATH . '/Core/Photonic.php';
	}
}

new Photonic_Plugin();

add_action('admin_init', '\Photonic_Plugin\photonic_utilities_init');
add_action('init', '\Photonic_Plugin\photonic_init', 0); // Delaying the start from 10 to 100 so that CPTs can be picked up

/**
 * Main plugin initiation
 */
function photonic_init() {
	global $photonic;
	$photonic = new Photonic();
}

/**
 * Loads up the utilities file
 */
function photonic_utilities_init() {
	require_once PHOTONIC_PATH . '/Core/Utilities.php';
}
