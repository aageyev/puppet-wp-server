define php5::module(
	$ensure   = present,
) {
	include apt::update

	package { $title :
		ensure  => $ensure,
		require => Class["apt::update"],
		notify  => Class["php5::fpm-service"],
	}

	# package {[
	# 	"php5-common",
	# 	"php5-curl",
	# 	"php5-gd",
	# 	"php5-imagick",
	# 	"php5-imap",
	# 	"php5-mcrypt",
	# 	"php5-memcache",
	# 	"php5-mysql",
	# 	"php5-sqlite",
	# 	"php5-xdebug",
	# 	"php5-xmlrpc",
	# 	"php5-xsl",
	# 	]:
	# 	ensure => installed,
	# 	require => Package["php5-cli"],
	# }
}