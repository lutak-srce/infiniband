# Class: infiniband
#
# This module deploys base OpenIB packages
#
class infiniband (
  $load_ipoib    = $infiniband::params::load_ipoib,
  $load_srp      = $infiniband::params::load_srp,
  $load_iser     = $infiniband::params::load_iser,
  $load_rds      = $infiniband::params::load_rds,
  $load_nfsordma = $infiniband::params::load_nfsordma,
) inherits infiniband::params {
  package { 'rdma':
    ensure => present,
  }
  package { 'infiniband-diags':
    ensure => present,
  }
  package { 'mstflint':
    ensure => present,
  }
  package { 'qperf':
    ensure => present,
  }
  package { 'librdmacm':
    ensure => present,
  }
  package { 'libmlx4':
    ensure => present,
  }
  package { 'libmthca':
    ensure => present,
  }
  file { '/etc/rdma/rdma.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('infiniband/rdma.conf.erb'),
    require => Package['rdma'],
  }
  service { 'rdma':
    ensure    => running,
    enable    => true,
    provider  => redhat,
    require   => File['/etc/rdma/rdma.conf'],
    subscribe => File['/etc/rdma/rdma.conf'],
  }
}
