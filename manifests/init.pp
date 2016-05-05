# == Class: rachosts
#
# automatically discovers rac cluster members and adds to hosts file
#
# === Parameters
#
# [autoupdate]
#   Will set the module to automatically update the packages it installs.
# [service_ensure]
#   Set the service the module is responsible for to that state.
# [package]
#   The package to install
# [svc_name]
#   The name of the service in init.d that we are running
# [domain]
#   Active directory domain to join
# [username]
#   The user name to use to join the AD domain above
# [password]
#   Password for the user above
#
# === Variables
#
#   NA
#
# === Examples
#
# include rachosts
#
# class { "rachosts":
# }
#
# === Authors
#
# stuartabramshumphries@gmail.com
#
# [Remember: No empty lines between comments and class definition]
class rachosts (
  $enable = true,
  $range = '21:00 - 23:00',
  $repeat = 1,
) {

  if $enable {

    schedule {'outside_prod':
      range =>  $range,
    }

    file {'hosts':
      ensure   => present,
      path     => '/etc/hosts',
      content  => template('rachosts/hostname.erb'),
      schedule => outside_prod,
    }
  }
  else {
    notify{'Module rachosts is disabled on this host':}
  }
}
