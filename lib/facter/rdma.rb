Facter.add('rdma') do
  setcode do
    if File.executable? '/usr/sbin/ibstat'
      if Facter::Core::Resolution.execute('/usr/sbin/ibstat').lines.grep(/State.*Active/) != []
        true
      else
        false
      end
    else
      false
    end
  end
end
