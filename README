Puppet module to setup G-wan
============================
This modules helps setup G-wan and configure your vhosts.

Parameters
==========
[*vhost_name*]
This parameter is to configure the different vhosts you want to create under Gwan.

[*vhost_path*]
This is the path for your document_root

USAGE
=====
Include the module gwan on your nodes.pp

<pre>
include gwan
</pre>

Add as many vhosts as you like.

<pre>
 gwan::resource::virtualhost {
   'domain.com':
     ensure     => 'present'
 }
</pre>

Authors
=======
Rhommel Lamas <roml@rhommell.com>

Support
========
Please log tickets and issues at our [Puppet G-wan](https://github.com/rhoml/puppet-gwan/issues)

LICENSE
========
MIT License refer to [LICENSE](https://github.com/rhoml/puppet-gwan/LICENSE).

