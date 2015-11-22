# Class: infiniband::srp
#
# This module manages OpenIB SCSI RDMA Protocol
#
class infiniband::srp {
  require ::infiniband

  package { 'srptools':
    ensure => present,
  }
  # fixes package startup script (remove '-n' and check interfaces)
  file { '/usr/sbin/srp_daemon.sh':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///modules/infiniband/srp_daemon.sh',
    require => Package['srptools'],
  }

  # if Subnet Manager is on same machine
  # it has to be started before srpd!
  service { 'srpd':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [
      Package['srptools'],
      Service['rdma'],   # provided by class 'infiniband'
      File['/usr/sbin/srp_daemon.sh'],
    ],
  }

}
