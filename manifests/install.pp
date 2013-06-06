# == Class: gwan
#
# Full description of class gwan here.
#
# === Parameters
#
# Document parameters here.
#
# [*port*]
# This parameter is to configure the listen port of Gwan
#
# [*prefix*]
# This is the directory where you want to setup G-wan
#
# [*version*]
# This is the version of your g-wan install package on the fileserver

# === USAGE
# Include the module on the nodes.pp or site.pp
# include gwan::install
#
class gwan::install (
  $port        = '8080',
  $prefix      = '/usr/share',
  $version     = '3.12.25'
  ){

  require gwan::dependencies

  File {
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  # Ensure /var/www exists
  if ! defined(File['/var/www']) {
    file { '/var/www': ensure => 'directory' }
  }

  # Ensure /usr/local/src diretory exists
  if ! defined(File["/usr/local/src"]) {
    file { "/usr/local/src": ensure  => 'directory' }
  }

  file { "/usr/local/src/gwan-${version}.tar.gz":
    source  => "puppet:///modules/gwan/gwan-${version}.tar.gz",
    alias   => 'gwan-source-tgz',
    before  => Exec['untar-gwan-source']
  }

  # Untar the gwan file.
  exec { "tar xzf /usr/local/src/gwan-${version}.tar.gz":
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    cwd       => "/usr/share",
    creates   => "/usr/share/gwan",
    alias     => "untar-gwan-source",
    subscribe => File["gwan-source-tgz"]
  }

    # Ensure Gwan vhost directory exists
  if ! defined(File["/usr/share/gwan/0.0.0.0_${port}"]) {
    file { "/usr/share/gwan/0.0.0.0_${port}": ensure  => 'directory' }
  }

  # Ensure Gwan vhost directory exists
  if ! defined(File['/var/www/gwan']) {
    file {
      '/var/www/gwan':
        ensure  => 'link',
        target  => "/usr/share/gwan/0.0.0.0_${port}",
        require => File['/var/www']
    }
  }

  # Ensure Catch all exists
  if ! defined(File['/var/www/gwan/#0.0.0.0']) {
    file { '/var/www/gwan/#0.0.0.0':
      ensure  => 'directory',
      require => File['/var/www/gwan']
    }
  }

  if ! defined(File['/var/www/gwan/#0.0.0.0/www']) {
    file { '/var/www/gwan/#0.0.0.0/www':
      ensure  => 'directory',
      require => File['/var/www/gwan/#0.0.0.0']
    }
  }

  file { '/var/www/gwan/#0.0.0.0/www/index.html':
    ensure  => 'present',
    source  => 'puppet:///modules/gwan/default.html',
    require => File['/var/www/gwan/#0.0.0.0/www']
  }

  # Creates a link to gwan executable file on /usr/sbin/gwan
  file { '/usr/sbin/gwan':
    ensure  => 'link',
    target  => "${prefix}/gwan-${version}/gwan",
    require => File["/usr/local/src/gwan-${version}.tar.gz"]
  }

  # Create Gwan init script.
  file { '/etc/init.d/gwan':
    ensure  => 'present',
    content => template('gwan/gwan.erb')
  }

  # Ensure Gwan starts on inittab level 2
  file { '/etc/rc2.d/S01gwan':
    ensure  => 'link',
    target  => '/etc/init.d/gwan',
    require => File['/etc/init.d/gwan']
  }

  exec { '/etc/init.d/gwan restart':
    command     => '/etc/init.d/gwan restart',
    refreshonly => true,
    alias       => 'reload-gwan',
    require     => File['/etc/init.d/gwan']
  }
}
