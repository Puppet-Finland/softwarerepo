#
# == Class: softwarerepo
#
# Generic software repository configuration not tied to any particular software 
# repository types. Currently required by the 'reprepro' (apt) and 'createrepo' 
# (yum) modules.
#
# == Parameters
#
# [*configure_webserver*]
#   Select which webserver to configure. Valid values are 'apache2', 'nginx' and 
#   'false' (don't configure). Currently the value 'nginx' does nothing. 
#   Defaults to 'false'.
#
# == Examples
#
# class { 'softwarerepo':
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
    $configure_webserver='false'
)
{
    include softwarerepo::install
    include softwarerepo::config

    if $configure_webserver == 'apache2' {
        include softwarerepo::config::apache2
    }
}
