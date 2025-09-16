<?php

namespace PortfolioMC\Platforms;

use PortfolioMC\Components\Pagination;

require_once PHOTONIC_PATH . '/Components/Pagination.php';

interface Pageable {
	public function get_pagination($entity, array $short_code = []): Pagination;
}
