node php-app-server inherits default-server {
	class { "php5::php5-fpm" : post_max_size => '1m', upload_max_filesize => '1m' }
	php5::module { [ "php5-mysql" , "php5-curl" ] : }
	php5::config::fpm-pool { "www1" :
		listen_port       => 9001,
		max_children      => 128,
		start_servers     => 40,
		min_spare_servers => 32,
		max_spare_servers => 56,
	}
	php5::config::fpm-pool { "www2" :
		listen_port       => 9002,
		max_children      => 128,
		start_servers     => 40,
		min_spare_servers => 32,
		max_spare_servers => 56,
	}
	$php_fpm_pool01 = [
		'127.0.0.1:9001',
		'127.0.0.1:9002',
	]
}
node nginx-php-app-server inherits php-app-server {
	$php_fpm_pool01 = [
		'127.0.0.1:9001',
		'127.0.0.1:9002',
	]
	class { "nginx::config" :
		worker_processes     => 4,
		worker_connections   => 10240,
		worker_rlimit_nofile => 10240,
		multi_accept         => 'off',
	}
	@nginx::config::upstream { 'php5-www' : backend => $php_fpm_pool01 }
}
node wp01 inherits nginx-php-app-server {
	nginx::config::php5-app { "wp01.agavoo.net":
		upstream => 'php5-www',
		template => 'wordpress',
	}
}