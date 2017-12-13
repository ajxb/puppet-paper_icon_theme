# paper_icon_theme::params
#
# Handles the module default parameters
#
class paper_icon_theme::params {
  $package_ensure = 'latest'
  $user = undef

  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
