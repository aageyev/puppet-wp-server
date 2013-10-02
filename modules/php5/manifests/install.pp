class php5::install(
	$ensure   = present,
) {
	include apt::update

	package { ["php5-cli","php5-suhosin","php5-common"] :
		ensure  => $ensure,
		require => Class["apt::update"],
	}
}