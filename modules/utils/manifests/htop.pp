class utils::htop (
	$package  = "htop",
	$ensure = 'installed'
) {
	package { $package :
		ensure	=> $ensure,
	}
}