# Class: infiniband::node
#
# This module manages OpenIB rdma service
#
class infiniband::node inherits infiniband {
  service { 'rdma':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['rdma'],
  }
}
