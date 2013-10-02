Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}
#
# TODO move ssh users and port to separate file
$ssh_port = 4546
include ssh::auth
$users = ["andrey","alt.mbox@gmail.com","roman_chichina@mail.ru"]

ssh::auth::key { $users : }

import 'defaults.pp'
import 'puppet-master.pp'
import 'webserver-nodejs.pp'
import 'mysqldb.pp'
import 'php-app-server.pp'
