class utils::mc (
	$package  = "mc",
	$ensure = 'installed'
) {
	package { $package :
		ensure	=> $ensure,
	}
}