Ohai.plugin(:PrivateIpaddress) do
  provides "private_ipaddress"
  depends "network/interfaces"

  collect_data(:default) do
    Ohai::Log.info("Finding private ipaddress")
    eth1_addresses.each do |ip, params|
      if inet_ip?(params)
        private_ipaddress ip
        Ohai::Log.info("The private ipaddress is set to #{ip}")
      end
    end
  end

  def eth1_addresses
    return [] unless eth1_interface
    eth1_interface["addresses"]
  end

  def inet_ip?(params)
    params['family'] == ('inet')
  end

  def eth1_interface
    network["interfaces"]["eth1"]
  end
end
