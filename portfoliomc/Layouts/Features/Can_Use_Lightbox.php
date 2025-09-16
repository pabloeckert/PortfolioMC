<?php

namespace PortfolioMC\Layouts\Features;

use PortfolioMC\Core\Photonic;
use PortfolioMC\Lightboxes\BaguetteBox;
use PortfolioMC\Lightboxes\BigPicture;
use PortfolioMC\Lightboxes\Colorbox;
use PortfolioMC\Lightboxes\Fancybox;
use PortfolioMC\Lightboxes\Fancybox2;
use PortfolioMC\Lightboxes\Fancybox3;
use PortfolioMC\Lightboxes\Fancybox4;
use PortfolioMC\Lightboxes\Featherlight;
use PortfolioMC\Lightboxes\GLightbox;
use PortfolioMC\Lightboxes\Image_Lightbox;
use PortfolioMC\Lightboxes\Lightbox;
use PortfolioMC\Lightboxes\Lightcase;
use PortfolioMC\Lightboxes\Lightgallery;
use PortfolioMC\Lightboxes\Magnific;
use PortfolioMC\Lightboxes\None;
use PortfolioMC\Lightboxes\PhotoSwipe;
use PortfolioMC\Lightboxes\PhotoSwipe5;
use PortfolioMC\Lightboxes\PrettyPhoto;
use PortfolioMC\Lightboxes\Spotlight;
use PortfolioMC\Lightboxes\Strip;
use PortfolioMC\Lightboxes\Swipebox;
use PortfolioMC\Lightboxes\Thickbox;
use PortfolioMC\Lightboxes\VenoBox;

trait Can_Use_Lightbox {
	/**
	 * @return Lightbox
	 */
	public static function get_lightbox(): Lightbox {
		$map = [
			'baguettebox'   => 'BaguetteBox.php',
			'bigpicture'    => 'BigPicture.php',
			'colorbox'      => 'Colorbox.php',
			'fancybox'      => 'Fancybox.php',
			'fancybox2'     => 'Fancybox2.php',
			'fancybox3'     => 'Fancybox3.php',
			'fancybox4'     => 'Fancybox4.php',
			'featherlight'  => 'Featherlight.php',
			'glightbox'     => 'GLightbox.php',
			'imagelightbox' => 'Image_Lightbox.php',
			'lightcase'     => 'Lightcase.php',
			'lightgallery'  => 'Lightgallery.php',
			'magnific'      => 'Magnific.php',
			'photoswipe'    => 'PhotoSwipe.php',
			'photoswipe5'    => 'PhotoSwipe5.php',
			'prettyphoto'   => 'PrettyPhoto.php',
			'spotlight'     => 'Spotlight.php',
			'swipebox'      => 'Swipebox.php',
			'strip'         => 'Strip.php',
			'thickbox'      => 'Thickbox.php',
			'venobox'       => 'VenoBox.php',
			'none'          => 'None.php',
		];
		$library = Photonic::$library;
		require_once PHOTONIC_PATH . '/Lightboxes/' . $map[$library];

		if ('baguettebox' === $library) {
			$lightbox = BaguetteBox::get_instance();
		}
		elseif ('bigpicture' === $library) {
			$lightbox = BigPicture::get_instance();
		}
		elseif ('colorbox' === $library) {
			$lightbox = Colorbox::get_instance();
		}
		elseif ('fancybox' === $library) {
			$lightbox = Fancybox::get_instance();
		}
		elseif ('fancybox2' === $library) {
			$lightbox = Fancybox2::get_instance();
		}
		elseif ('fancybox3' === $library) {
			$lightbox = Fancybox3::get_instance();
		}
		elseif ('fancybox4' === $library) {
			$lightbox = Fancybox4::get_instance();
		}
		elseif ('featherlight' === $library) {
			$lightbox = Featherlight::get_instance();
		}
		elseif ('glightbox' === $library) {
			$lightbox = GLightbox::get_instance();
		}
		elseif ('imagelightbox' === $library) {
			$lightbox = Image_Lightbox::get_instance();
		}
		elseif ('lightcase' === $library) {
			$lightbox = Lightcase::get_instance();
		}
		elseif ('lightgallery' === $library) {
			$lightbox = Lightgallery::get_instance();
		}
		elseif ('magnific' === $library) {
			$lightbox = Magnific::get_instance();
		}
		elseif ('photoswipe' === $library) {
			$lightbox = PhotoSwipe::get_instance();
		}
		elseif ('photoswipe5' === $library) {
			$lightbox = PhotoSwipe5::get_instance();
		}
		elseif ('prettyphoto' === $library) {
			$lightbox = PrettyPhoto::get_instance();
		}
		elseif ('spotlight' === $library) {
			$lightbox = Spotlight::get_instance();
		}
		elseif ('swipebox' === $library) {
			$lightbox = Swipebox::get_instance();
		}
		elseif ('strip' === $library) {
			$lightbox = Strip::get_instance();
		}
		elseif ('thickbox' === $library) {
			$lightbox = Thickbox::get_instance();
		}
		elseif ('venobox' === $library) {
			$lightbox = VenoBox::get_instance();
		}
		else {
			$lightbox = None::get_instance();
		}
		return $lightbox;
	}
}
