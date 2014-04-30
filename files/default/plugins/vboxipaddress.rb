Ohai.plugin(:Vboxipaddress) do
  provides "ipaddress"
  depends "ipaddress", "network/interfaces", "virtualization/system", "etc/passwd"

  collect_data(:default) do
    if virtualization["system"] == "vbox"
      if etc["passwd"].any? { |k,v| k == "vagrant"}
        if network["interfaces"]["eth1"]
          network["interfaces"]["eth1"]["addresses"].each do |ip, params|
            if params['family'] == ('inet')
              ipaddress ip
            end
          end
        end
      end
    end
  end
end
