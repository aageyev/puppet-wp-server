class utils::rsync (
	$package  = "rsync",
	$ensure = 'installed'
) {
	package { $package :
		ensure	=> $ensure,
	}
}