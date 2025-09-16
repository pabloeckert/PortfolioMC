<?php

namespace PortfolioMC\Components;

use PortfolioMC\Layouts\Core_Layout;
use PortfolioMC\Platforms\Base;

class Error implements Printable {
	private $message;

	/**
	 * Error constructor.
	 *
	 * @param String $message
	 */
	public function __construct($message) {
		$this->message = $message;
	}

	/**
	 * {@inheritDoc} - an Error
	 */
	public function html(Base $module, Core_Layout $layout = null, $print = false): string { // phpcs:ignore Generic.CodeAnalysis.UnusedFunctionParameter
		$ret = "
<div class='photonic-error photonic-{$module->provider}-error' id='photonic-{$module->provider}-error-{$module->gallery_index}'>
	<span class='photonic-error-icon photonic-icon'>&nbsp;</span>
	<div class='photonic-message'>
		{$this->message}
	</div>
</div>\n";
		if ($print) {
			echo wp_kses_post($ret);
		}

		return wp_kses_post($ret);
	}
}
