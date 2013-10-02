define nginx::config::upstream (
	$backend = '',
	$ensure  = present,
	$type    = balanser,
	$ip_hash = '',
){
	file { $title :
		path    => "/etc/nginx/conf.d/${title}.upstream.conf",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("nginx/conf.d/upstream.erb"),
		require => Class["nginx::config"],
		notify  => Class["nginx::service"],
	}

}