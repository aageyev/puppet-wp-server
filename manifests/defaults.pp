node default-server {
	include ufw
	include ntp
	include vcs::mercurial
	class { "timezone" : timezone => 'Etc/UTC' }
	class {"ssh::server" : port => $ssh_port }
	ssh::auth::server { ["andrey"]: user => "root", home => "/root", }
	ufw::allow { "allow-ssh-on": port => $ssh_port, ip => $::ipaddress, }
}

node default inherits default-server {
	# include anonymizer
}
