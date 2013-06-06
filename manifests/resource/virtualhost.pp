# = Define: G-WAN virtualhosts
define gwan::resource::virtualhost (
  $ensure       = 'present',
  $vhost_name   = 'gwan.domain.com',
  $vhost_path   = '/var/www/gwan'
  ){

  File {
    owner => 'deploy',
    group => 'nogroup',
  }

  ## Shared Variables
  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => file,
  }

  # Ensure vhost directory exists
  if ! defined(File["${vhost_path}/#${vhost_name}"]) {
    file { "${vhost_path}/#${vhost_name}": ensure => 'directory' }
  }

  # Ensure vhost directory exists
  if ! defined(File["${vhost_path}/#${vhost_name}/www"]) {
    file { "${vhost_path}/#${vhost_name}/www": ensure => 'directory' }
  }

}
