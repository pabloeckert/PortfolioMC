<?php

namespace PortfolioMC\Lightboxes;

require_once 'Lightbox.php';

class Image_Lightbox extends Lightbox {
	protected function __construct() {
		$this->library = 'imagelightbox';
		parent::__construct();
	}
}
