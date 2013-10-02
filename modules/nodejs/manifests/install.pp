class nodejs::install (
	$ensure  = 'installed',
	$package = "nodejs",
){
	include apt
	apt::ppa { 'ppa:chris-lea/node.js': } ->
	package { $package :
		ensure  => $ensure,
	}
}