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

  if ($package_ensure == 'absent') or ($package_ensure == 'purged') {
    gnome::gsettings { 'desktop.interface_icon-theme':
      schema => $paper_icon_theme::params::schema,
      key    => 'icon-theme',
      value  => $paper_icon_theme::params::default_iconset,
      user   => $user,
    }
  } else {
    gnome::gsettings { 'desktop.interface_icon-theme':
      schema => $paper_icon_theme::params::schema,
      key    => 'icon-theme',
      value  => '\'Paper\'',
      user   => $user,
    }
  }
}
