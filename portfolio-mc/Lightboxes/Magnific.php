<?php

namespace PortfolioMC\Lightboxes;

use PortfolioMC\Lightboxes\Features\Show_Videos_Inline;

require_once 'Lightbox.php';
require_once 'Features/Show_Videos_Inline.php';

class Magnific extends Lightbox {
	use Show_Videos_Inline;

	protected function __construct() {
		$this->library = 'magnific';
		parent::__construct();
	}
}
