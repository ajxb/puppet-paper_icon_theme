# paper_icon_theme::params
#
# Handles the module default parameters
#
class paper_icon_theme::params {
  $package_ensure = 'latest'
  $user           = undef

  # Check that the desktop is defined and supported, error if not
  if ($facts['desktop'] != undef and $facts['desktop']['type'] != undef) {
    case $facts['desktop']['type'] {
      'cinnamon': {
        $schema = 'org.cinnamon.desktop.interface'
        $default_iconset = '\'Mint-X\''
      }
      default:    {
        fail("Desktop ${facts['desktop']['type']} is not supported")
      }
    }
  } else {
    fail('fact desktop.type is not defined, please ensure this fact is defined and run again')
  }

  # Check that the Operating System is supported, error if not
  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
