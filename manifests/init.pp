# == Class: gwan
#
# This modules helps setup G-wan and configure your vhosts..
#
# === Parameters
#
# [*vhost_name*]
# This parameter is to configure the different vhosts you want to create under Gwan.
#
# [*vhost_path*]
# This is the path for your document_root
#
# === USAGE
# Include the module on the nodes.pp or site.pp
#
# include gwan::install
#
# gwan::resource::virtualhost {
#   'domain.com':
#     ensure     => 'present'
# }
#
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === LICENSE
# MIT 2013
class gwan {
  include gwan::install
}
