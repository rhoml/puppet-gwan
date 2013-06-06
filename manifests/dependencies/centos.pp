class gwan::dependencies::centos {
  if ! defined(Package['libc-dev-bin']) {       package { 'libc-dev-bin':       ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['libc6-dev']) {          package { 'libc6-dev':          ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['gcc']) {                package { 'gcc':                ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['javacc']) {             package { 'javacc':             ensure => 'installed', provider => 'yum' } }
}
