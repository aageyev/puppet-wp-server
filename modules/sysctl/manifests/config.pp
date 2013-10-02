define sysctl::config ( $value ) {
	include sysctl
	$key = $title
	$context = "/files/etc/sysctl.conf"
	augeas { "sysctl.conf/$key":
		context => "$context",
		onlyif  => "get $key != '$value'",
		changes => "set $key '$value'",
		notify  => Exec["sysctl"],
	}
}