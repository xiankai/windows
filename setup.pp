class setup {
	$programdata = "C:/ProgramData/PuppetLabs/puppet/etc"

	define puppet_module {
		$puppet = "\"C:/Program Files (x86)/Puppet Labs/Puppet/bin/puppet.bat\""

		$vars = split($name, '/')
		exec { "${puppet} module install ${name} --module_repository=http://forge.puppetlabs.com":
			creates => "${setup::programdata}/modules/${vars[1]}/Modulefile",
		}
	}

	puppet_module { [
		"rismoney/chocolatey",
		"liamjbennett/windows_autoupdate",
		"joshcooper/powershell",
	]: }

	file { "${programdata}/puppet.conf":
		ensure => present,
		source => "//VBOXSVR/vagrant/puppet.conf",
		source_permissions => ignore,
	}
}

include setup