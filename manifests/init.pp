# Class: paper_icon_theme
#
# Manage installation and configuration of the Paper icon theme on Ubuntu, installing from ppa
#
# @example Declaring the class
#   class { 'paper_icon_theme':
#     user => 'theuser',
#   }
#
# @param [String] package_ensure Specifies whether to install the paper-icon-theme package
# @param [String] user           Mandatory parameter that specifies the user to configure the font for
class paper_icon_theme (
  String $package_ensure = $paper_icon_theme::params::package_ensure,
  String $user = $paper_icon_theme::params::user,
) inherits paper_icon_theme::params {
  assert_type(String[1], $package_ensure)
  assert_type(String[1], $user)

  class { 'paper_icon_theme::install':
    package_ensure => $package_ensure,
  }

  class { 'paper_icon_theme::config':
    package_ensure => $package_ensure,
    user           => $user,
  }

  contain paper_icon_theme::install
  contain paper_icon_theme::config

  Class['paper_icon_theme::install']
    -> Class['paper_icon_theme::config']
}
