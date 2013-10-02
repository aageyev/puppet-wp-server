define php5::config::fpm-pool(
	$user              = 'www-data',
	$group             = 'www-data',
	$ensure            = present,
	$listen_address    = '127.0.0.1',
	$listen_port       = 9000,
	$max_children      = 10,
	$start_servers     = 4,
	$min_spare_servers = 2,
	$max_spare_servers = 6,
){
	include php5::fpm-service
	
	file { $title :
		path    => "/etc/php5/fpm/pool.d/${title}.conf",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("php5/fpm/pool.d/pool.conf.erb"),
		require => Package["php5-fpm"],
		notify  => Class["php5::fpm-service"],
	}
}