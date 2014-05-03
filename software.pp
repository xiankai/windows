class chocolatey {
	exec { 'iex ((new-object net.webclient).DownloadString("https://chocolatey.org/install.ps1"))':
		creates => "C:/Chocolatey",
		provider => "powershell",
		timeout => 0,
	}
}

class software {
	$defaults = {
		ensure => installed,
		provider => 'chocolatey',
		require => Class['chocolatey'],
	}

	create_resources('package', hiera('chocolatey'), $defaults)

	$more_defaults = {
		ensure => installed,
	}

	create_resources('package', hiera('package'), $more_defaults)
}

include chocolatey, software