# Class: infiniband::sm
#
# This module manages OpenIB Subnet Manager
#
class infiniband::sm {
  include infiniband
  package { 'opensm':
    ensure => present,
  }
  # fixes package startup script: delay increased from 1 to 20
  file { '/etc/init.d/opensm':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///modules/infiniband/opensm',
    require => Package['opensm'],
  }
  service { 'opensm':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [ File['/etc/init.d/opensm'], Service['rdma'] ],
  }
}
