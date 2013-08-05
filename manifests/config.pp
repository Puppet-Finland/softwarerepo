#
# == Class: softwarerepo::config
#
# Configure things required by all software repository management tools
#
class softwarerepo::config($documentroot) {

    file { 'softwarerepo-repos':
        name => "${documentroot}/repos",
        ensure => directory,
        require => Class['webserver::config'],
    }

    file { 'softwarerepo-privatekey':
        name => '/root/repo-secret.gpg',
        source => 'puppet:///files/repo-secret.gpg',
        ensure => present,
        owner => root,
        group => root,
        mode => 600,
    }

    exec { 'softwarerepo-privatekey-import':
        command => 'gpg --allow-secret-key-import --import /root/repo-secret.gpg',
        cwd => '/tmp',
        path => '/usr/bin',
        refreshonly => true,
        subscribe => File['softwarerepo-privatekey'],
    }

    # The public key is needed by both GPG and our users, hence it's stored in 
    # the webserver directory
    file { 'softwarerepo-publickey':
        ensure => present,
        name => "${documentroot}/repos/repo-public.gpg",
        owner => root,
        group => root,
        mode => 644,
        source => 'puppet:///files/repo-public.gpg',
    }

    exec { 'softwarerepo-publickey-import':
        command => "gpg --import ${documentroot}/repos/repo-public.gpg",
        cwd => '/tmp',
        path => '/usr/bin',
        refreshonly => true,
        subscribe => File['softwarerepo-publickey'],
    }
}
