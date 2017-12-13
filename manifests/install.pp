# paper_icon_theme::install
#
# Handles the ppa setup and the Paper icon theme packages
#
# @param package_ensure Specifies whether to install the paper-icon-theme packages
class paper_icon_theme::install (
  String $package_ensure = $paper_icon_theme::params::package_ensure,
) inherits paper_icon_theme::params {
  include apt
  apt::ppa { 'ppa:snwh/pulp': }

  package { 'paper-icon-theme':
    ensure => $package_ensure,
  }

  Apt::Ppa['ppa:snwh/pulp']
    ~> Class['apt::update']
    -> Package[ 'paper-icon-theme' ]
}
