# == Class: rachosts
#
# automatically discovers rac cluster members and adds to hosts file
#
# === Parameters
#
#   NA
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
# as this is important I'm going to restrict usage to outside production hours
#
class rachosts (
  $enable = false,
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
