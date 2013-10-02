class vcs::git{
	package {[
		"git",
		"git-core",
		"git-svn",
		]:
		ensure => present,
	}
}