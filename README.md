# paper_icon_theme

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with paper_icon_theme](#setup)
  * [What paper_icon_theme affects](#what-paper_icon_theme-affects)
  * [Beginning with paper_icon_theme](#beginning-with-paper_icon_theme)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The paper_icon_theme module installs the [Paper icon theme](https://snwh.org/paper) from [ppa](https://launchpad.net/~snwh/+archive/ubuntu/pulp) on Ubuntu for Cinnamon based desktops.

## Setup

### What paper_icon_theme affects

* apt configuration to include Paper icon theme ppa
* gsettings to configure Paper icon theme for a specified user

### Dependencies

This module has a dependency on
[puppet-gnome](https://github.com/ajxb/puppet-gnome) which is not available on
Puppet Forge so will need to be downloaded and installed using your preferred
method, e.g. [librarian-puppet](http://librarian-puppet.com/)

### Beginning with paper_icon_theme

To install Paper icon theme:

```puppet
class { 'paper_icon_theme':
  package_ensure => 'latest',
  user           => 'ajxb',
}
```

## Usage

The default paper_icon_theme class installs paper-icon-theme. To use:

```puppet
class { 'paper_icon_theme':
  package_ensure => 'latest',
  user           => 'ajxb',
}
```

To configure the Cinnamon desktop the following fact must be defined:
```yaml
desktop:
  type: cinnamon
```

## Reference

### Classes

#### Public classes

* `paper_icon_theme`: Installs paper-icon-theme

#### Private classes

* `paper_icon_theme::config`: Handles the configuration of the theme
* `paper_icon_theme::params`: Handles the module default parameters
* `paper_icon_theme::install`: Handles the ppa setup and the Paper icon theme packages

### Parameters

The following parameters are available in the `paper_icon_theme` class:

#### `package_ensure`

Data type: String.

Whether to install the paper-icon-theme packages. Values: The same as used for the puppet package type, see [https://docs.puppet.com/puppet/latest/type.html#package-attribute-ensure](https://docs.puppet.com/puppet/latest/type.html#package-attribute-ensure)

Default value: 'latest'.

#### `user`

Data type: String.

The username to configure the icon theme for.

Default value: 'latest'.

## Limitations

This module has only been tested against Ubuntu 16.04.  As the Paper icon theme is a desktop theme this module will only produce tangible results when used with a desktop variant of Ubuntu.

## Development

### Contributing

Before starting your work on this module, you should fork the project to your GitHub account. This allows you to freely experiment with your changes. When your changes are complete, submit a pull request. All pull requests will be reviewed and merged if they suit some general guidelines:

* Changes are located in a topic branch
* For new functionality, proper tests are written
* Changes should not solve certain problems on special environments
* Your change does not handle third party software for which dedicated Puppet modules exist such as creating databases, installing webserver etc.
* Changes follow the recommended Puppet style guidelines from the [Puppet Language Style Guide](https://docs.puppet.com/puppet/latest/style_guide.html)

### Branches

Choosing a proper name for a branch helps us identify its purpose and possibly find an associated bug or feature. Generally a branch name should include a topic such as `bug` or `feature` followed by a description and an issue number if applicable. Branches should have only changes relevant to a specific issue.

```
git checkout -b bug/service-template-typo-1234
git checkout -b feature/config-handling-1235
```

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/) to verify functionality. For detailed information on using this tool, please see the relevant documentation.

#### Testing quickstart

```
gem install bundler
bundle install
rake spec
```
