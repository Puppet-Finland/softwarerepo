#
# == Class: softwarerepo::config::apache2
#
# Configure Apache2 for use with various software repositories
#
class softwarerepo::config::apache2($documentroot) {

    file { 'file-softwarerepo-softwarerepo':
        name => '/etc/apache2/conf.d/softwarerepo',
        ensure => present,
        content => template('softwarerepo/softwarerepo.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['apache2::install'],
        notify => Class['apache2::service'],
    }
}
