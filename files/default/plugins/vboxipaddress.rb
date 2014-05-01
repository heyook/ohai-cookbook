Ohai.plugin(:Vboxipaddress) do
  provides "ipaddress"
  depends "ipaddress", "network/interfaces", "virtualization/system", "etc/passwd"

  collect_data(:default) do
    Ohai::Log.info("Vboxipaddress working hard...")
    if virtualization["system"] == "vbox"
      if etc["passwd"].any? { |k,v| k == "vagrant"}
        if network["interfaces"]["eth1"]
          network["interfaces"]["eth1"]["addresses"].each do |ip, params|
            if params['family'] == ('inet')
              ipaddress ip
              Ohai::Log.info("ipaddress for vbox is #{ip}")
            end
          end
        end
      end
    end
  end
end
