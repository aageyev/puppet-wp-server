class php5::browscap (
	$ensure   = present,
	
) {
	file { "/etc/php5/extra" :
	    ensure  => "directory",
	    owner   => "root",
	    group   => "root",
	    mode    => 775,
		require => Package["php5-common"],
	}
	$url = 'http://tempdownloads.browserscap.com/stream.php?Full_PHP_BrowscapINI'
	exec { "downloads_browscap_ini" :
		command => "/usr/bin/wget $url -O /etc/php5/extra/browscap.ini",
		creates => "/etc/php5/extra/browscap.ini",
		require => File["/etc/php5/extra"],
	}
	
	# file { "browscap.ini" :
	# 	path    => '/etc/php5/extra/browscap.ini',
	# 	ensure  => $ensure,
	# 	owner   => 'root',
	# 	group   => 'root',
	# 	mode    => 0644,
	# 	source  => "puppet:///modules/php5/extra/browscap/php_browscap.ini",
	# 	# source  => "puppet:///modules/php5/extra/test.ini",
	# 	require => Package["php5-common"],
	# 	notify  => Service["php5-fpm"],	
	# }

}