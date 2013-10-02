class utils::zip (
	$package  = "zip",
	$ensure = 'installed'
) {
	package { $package :
		ensure	=> $ensure,
	}
}