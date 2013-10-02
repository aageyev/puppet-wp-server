define nginx::config::php5-app (
	$hostname          = '',
	$ip                = '0.0.0.0',   # can be array ?
	$port              = 80,
	$upstream          = undef, # can be array
	$ensure            = present,
	$template          = 'default_server',
	$app_base_dir      = '/var/www',
	$index_file        = 'index.php',
) {
	if $upstream {
    realize Nginx::Config::Upstream[$upstream]
  }
	$app_root_path = "$app_base_dir/$name"
	file { "$app_base_dir":
	    ensure => "directory",
	    owner  => "www-data",
	    group  => "www-data",
	    mode   => 755,
	} ->
	file { "$app_root_path":
	    ensure => "directory",
	    owner  => "www-data",
	    group  => "www-data",
	    mode   => 755,
	}

	file { $title :
		path    => "/etc/nginx/sites-available/$title",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("nginx/sites/${template}.erb"),
		require => Class["nginx::install"],
		notify  => Class["nginx::service"],
	}
	case $ensure {
		absent: {
			file { "${title}-enabled" :
				path    => "/etc/nginx/sites-enabled/${title}",
				ensure  => $ensure,
				notify  => Class["nginx::service"],
			}
		}
		present: {
			file { "${title}-enabled" :
				path    => "/etc/nginx/sites-enabled/${title}",
				ensure  => link,
				target  => "/etc/nginx/sites-available/${title}",
				require => File["/etc/nginx/sites-available/${title}"],
				notify  => Class["nginx::service"],
			}
		}
	}
}
