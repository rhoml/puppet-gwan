class gwan::dependencies::ubuntu {
  if ! defined(Package['build-essential']) {    package { 'build-essential':    ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libc-dev-bin']) {       package { 'libc-dev-bin':       ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libc6-dev']) {          package { 'libc6-dev':          ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['gcc']) {                package { 'gcc':                ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['javacc']) {             package { 'javacc':             ensure => 'installed', provider => 'aptitude' } }
}
