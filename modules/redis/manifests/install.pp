class redis::install (
	$ensure  = 'installed',
	$package = 'redis-server',
) {
	package { $package :
	    ensure  => $ensure,
	}
}