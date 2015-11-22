Facter.add('rdma') do
  setcode do
    if File.executable? '/usr/sbin/ibstat'
      if Facter::Util::Resolution.exec('/usr/sbin/ibstat').grep(/State.*Active/) != []
        true
      else
        false
      end
    else
      false
    end
  end
end
