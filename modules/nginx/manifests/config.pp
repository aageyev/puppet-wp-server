class nginx::config (
	$template               = 'default',
	$nginx                  = 'nginx',
	$worker_processes       = 2,
	$worker_connections     = 1024,
	$worker_rlimit_nofile   = '',
	$multi_accept           = '',
	$ensure                 = 'present',
){
	class { "nginx::install" : nginx => $nginx }
	include nginx::service

	file { "default-site":
		path    => "/etc/nginx/sites-enabled/default",
		ensure  => absent,
		notify  => Class["nginx::service"],
		require => Class["nginx::install"],
	}
	# $file_tpl = "nginx/nginx-$template.conf.erb"
	file { "nginx.conf":
		path    => "/etc/nginx/nginx.conf",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("nginx/nginx-$template.conf.erb"),
		require => Class["nginx::install"],
		notify  => Class["nginx::service"],
	}

	file { "log.formats":
		path    => "/etc/nginx/log.formats",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		source  => "puppet:///modules/nginx/log.formats",
		require => Class["nginx::install"],
		notify  => Class["nginx::service"],
	}
	nginx::config::error_pages { ['400','401','403','404','500','502','504'] : }
}
