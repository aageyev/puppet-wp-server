class timezone( $timezone = "Etc/UTC" ) {
		package { "tzdata":
			ensure  => installed,
    }
    file {"timezone":
			path    => "/etc/timezone",
			ensure  => present,
			mode    => 644,
			owner   => root,
			group   => root,
			content => template("timezone/timezone.erb"),
			notify  => Exec["set-timezone"],
    }
    exec{"set-timezone":
			path        => ["/usr/bin", "/usr/sbin", "/bin"],
			command     => "dpkg-reconfigure -f noninteractive tzdata",
			require     => File["timezone"],
			refreshonly => true,
    }
}