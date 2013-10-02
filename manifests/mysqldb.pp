node mysql-db inherits default-server {

	# Adding percona apt repo
	include percona::repo

	# tune /etc/sysctl.conf
	sysctl::config {
		"kernel.shmmax":     value =>  4187389952;
		"kernel.shmall":     value =>  1022312;
	}
	# tune security limits
	limits::config {
	  "mysql-soft-nofile" : domain => mysql, type => soft, item => nofile, value =>  10240;
	  "mysql-hard-nofile" : domain => mysql, type => hard, item => nofile, value =>  40960;
	  "mysql-soft-nproc"  : domain => mysql, type => soft, item => nproc,  value =>  10240;
	  "mysql-hard-nproc"  : domain => mysql, type => hard, item => nproc,  value =>  40960;
	}
	# TODO: Install typical configs
}

node db01 inherits mysql-db {
	# TODO: set mysql root password
	# TODO: config modifications
	# TODO: db and user management
}