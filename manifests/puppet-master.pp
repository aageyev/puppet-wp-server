
# node pm-dev inherits default-server {}
node puppet-master inherits default-server {
	include ssh::auth::keymaster
}

node pm inherits puppet-master {

}
