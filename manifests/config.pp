# paper_icon_theme::config
#
# Configures the paper icon theme as system default
#
# @param [String] package_ensure Specifies whether to install the paper-icon-theme package
# @param [String] user           Mandatory parameter that specifies the user to configure the font for
class paper_icon_theme::config (
  String $package_ensure = $paper_icon_theme::params::package_ensure,
  String $user = $paper_icon_theme::params::user,
) inherits paper_icon_theme::params {
  assert_type(String[1], $package_ensure)
  assert_type(String[1], $user)

  # Configure variables for the given desktop
  # Defaults assume a Ubuntu installation with Gnome / Unity desktop which can
  # be overridden using custom fact desktop.type
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
    $schema = 'org.gnome.desktop.interface'
    $default_iconset = '\'ubuntu-mono-dark\''
  }

  if ($package_ensure == 'absent') or ($package_ensure == 'purged') {
    gnome::gsettings { 'desktop.interface_icon-theme':
      schema => $schema,
      key    => 'icon-theme',
      value  => $default_iconset,
      user   => $user,
    }
  } else {
    gnome::gsettings { 'desktop.interface_icon-theme':
      schema => $schema,
      key    => 'icon-theme',
      value  => '\'Paper\'',
      user   => $user,
    }
  }
}
