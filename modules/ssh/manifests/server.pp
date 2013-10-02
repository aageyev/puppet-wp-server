class ssh::server($port = 22){
	include ssh::server::install
	include ssh::server::service
	class {"ssh::server::config": port => $port}
}

class ssh::server::config($port = 22) {
	augeas { "sshd_config":
		context => "/files/etc/ssh/sshd_config",
		changes => [
			"set Port $port",
		],
		require => Class["ssh::server::install"],
		notify  => Class["ssh::server::service"],
	}
}
class ssh::server::install {
	package { "ssh":
		ensure => present,
	}
}

class ssh::server::service {
	service { "ssh":
		ensure     => running,
		hasstatus  => true,
		hasrestart => true,
		enable     => true,
		require    => Class["ssh::server::config"],
	}
}
