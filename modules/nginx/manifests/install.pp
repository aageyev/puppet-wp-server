class nginx::install (
	$nginx  = "nginx",
	$ensure = 'installed'
) {
	include apt
	include nginx::service
	apt::ppa { "ppa:nginx/stable": } ->
	package { $nginx :
		ensure  => $ensure,
		notify  => Class["nginx::service"],
	}
}