#
# == Class: softwarerepo
#
# Generic software repository configuration not tied to any particular software 
# repository types. Currently required by the 'reprepro' (apt) and 'createrepo' 
# (yum) modules.
#
# == Parameters
#
# [*documentroot*]
#   Webserver's document root directory. Defaults to 
#   $::webserver::config::documentroot.
# [*configure_webserver*]
#   Select which webserver to configure. Valid values are 'apache2', 'nginx' and 
#   'false' (don't configure). Currently the value 'nginx' does nothing. 
#   Defaults to 'false'.
#
# == Examples
#
# class { 'softwarerepo':
#   documentroot => '/home/www',
#   configure_webserver => 'apache2',
# }
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class softwarerepo
(
    $documentroot=$::webserver::config::documentroot,   
    $configure_webserver='false'
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_softwarerepo', 'true') != 'false' {

    include softwarerepo::install

    class { 'softwarerepo::config':
        documentroot => $documentroot,
    }

    if $configure_webserver == 'apache2' {
        class { 'softwarerepo::config::apache2':
            documentroot => $documentroot,
        }
    }
}
}
