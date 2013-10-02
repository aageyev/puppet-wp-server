define nginx::config::error_pages (
	$ensure    = present,
) {
	file { "$title.html" :
		path    => "/usr/share/nginx/html/$title.html",
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		content => template("nginx/err.html.erb"),
		require => Class["nginx::install"],
	}
}
