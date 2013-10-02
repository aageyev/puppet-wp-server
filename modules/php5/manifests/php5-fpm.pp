class php5::php5-fpm(
	$ensure              = present,
	$browscap            = 'on',
	$display_errors      = 'Off',
	$post_max_size       = '10m',
	$upload_max_filesize = '10M',
	$timezone            = 'UTC',
) {
	include apt::update
	include php5::install
	include php5::fpm-service

	package { "php5-fpm" :
		ensure  => installed,
		require => Class["apt::update"],
	}

	file { "php-fpm.conf":
		path    => "/etc/php5/fpm/php-fpm.conf",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("php5/fpm/php-fpm.conf.erb"),
		require => Package["php5-fpm"],
		notify  => Class["php5::fpm-service"],
	}

	file { "php.ini":
		path    => "/etc/php5/fpm/php.ini",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("php5/fpm/php.ini.erb"),
		require => Package["php5-fpm"],
		notify  => Class["php5::fpm-service"],
	}
	if $browscap == 'on' {
		include php5::browscap
	}
	file { "default-pool":
		path    => "/etc/php5/fpm/pool.d/www.conf",
		ensure  => absent,
		notify  => Class["php5::fpm-service"],
	}
}