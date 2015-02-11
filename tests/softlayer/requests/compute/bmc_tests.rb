#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

Shindo.tests("Fog::Compute[:softlayer] | server requests", ["softlayer"]) do
  tests('success') do

    @sl_connection = Fog::Compute[:softlayer]

    @bmc = {
        :operatingSystemReferenceCode      => 'UBUNTU_LATEST',
        :processorCoreAmount               => 2,
        :memoryCapacity                    => 2,
        :hourlyBillingFlag                 => true,
        :domain                            => 'example.com',
        :hostname                          => 'test',
        :datacenter                        => { :name => 'wdc01' }
    }

    tests("#create_bare_metal_server('#{@bmc}')") do
      response = @sl_connection.create_bare_metal_server(@bmc)
      @server_id = response.body['id']
      data_matches_schema(Softlayer::Compute::Formats::BareMetal::SERVER, {:allow_extra_keys => true}) { response.body }
      data_matches_schema(201) { response.status }
    end

    tests("#get_bare_metal_servers()") do
      @sl_connection.get_bare_metal_servers.body.each do |bms|
        data_matches_schema(Softlayer::Compute::Formats::BareMetal::SERVER) { bms }
      end
    end

    tests("#power_on_bare_metal_server('#{@server_id})'") do
      response = @sl_connection.power_on_bare_metal_server(@server_id)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#power_off_bare_metal_server('#{@server_id})'") do
      response = @sl_connection.power_off_bare_metal_server(@server_id)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#reboot_bare_metal_server('#{@server_id})', true") do
      response = @sl_connection.reboot_bare_metal_server(@server_id, true)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#reboot_bare_metal_server('#{@server_id})', false") do
      response = @sl_connection.reboot_bare_metal_server(@server_id, false)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#delete_bare_metal_server('#{@server_id})'") do
      response = @sl_connection.delete_bare_metal_server(@server_id)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end
  end

  tests('failure') do
    bmc = @bmc.dup; bmc.delete(:hostname)

    tests("#create_bare_metal_server('#{bmc}')") do
      response = @sl_connection.create_bare_metal_server(bmc)
      data_matches_schema('SoftLayer_Exception_MissingCreationProperty'){ response.body['code'] }
      data_matches_schema(500){ response.status }
    end

    tests("#create_bare_metal_server(#{[@bmc]}").raises(ArgumentError) do
      @sl_connection.create_bare_metal_server([@bmc])
    end

    tests("#power_on_bare_metal_server('#{bmc}')") do
      response = @sl_connection.power_on_bare_metal_server(bmc)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404){ response.status }
    end

    tests("#power_off_bare_metal_server('#{bmc}')") do
      response = @sl_connection.power_off_bare_metal_server(bmc)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404){ response.status }
    end

    tests("#reboot_bare_metal_server('#{bmc}', true)") do
      response = @sl_connection.reboot_bare_metal_server(bmc, true)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404){ response.status }
    end

    tests("#reboot_bare_metal_server('#{bmc}', false)") do
      response = @sl_connection.reboot_bare_metal_server(bmc, false)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404){ response.status }
    end

    tests("#delete_bare_metal_server('99999999999999')'") do
      response = @sl_connection.delete_bare_metal_server(99999999999999)
      data_matches_schema(String) {response.body}
      data_matches_schema(500) {response.status}
    end

  end
end
