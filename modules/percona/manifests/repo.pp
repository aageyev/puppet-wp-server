class percona::repo (
	$ensure   = present,
){
	apt::source { "percona.com":
		location   => "http://repo.percona.com/apt",
		release    => "precise",
		repos      => "main",
		key        => "CD2EFD2A",
		key_server => "keys.gnupg.net",
	} ->
	package { "xtrabackup" : ensure => $ensure, }
}