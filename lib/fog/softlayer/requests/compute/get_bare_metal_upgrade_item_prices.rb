#
# Author:: Matheus Francisco Barra Mina (<mfbmina@gmail.com>)
# © Copyright IBM Corporation 2015.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#
module Fog
  module Compute
    class Softlayer
      class Mock
        # Gets all Bare Metal upgrade item prices
        # @param [Integer] id
        # @return [Excon::Response]
        def get_bare_metal_upgrade_item_prices(id)
          response = Excon::Response.new
          found = self.get_bare_metal_servers.body.map{|server| server['id']}.include?(id)
          unless found
            response.status = 404
            response.body = {
                "error" => "Unable to find object with id of '#{id}'.",
                "code" => "SoftLayer_Exception_ObjectNotFound"
            }
          else
            response.status = 200
            response.body = get_upgrade_item_prices
          end
          response
        end
      end

      class Real
        def get_bare_metal_upgrade_item_prices(id)
          request(:hardware_server, "#{id}/getUpgradeItemPrices", :body => true, :http_method => :POST)
        end
      end
    end
  end
end

module Fog
  module Compute
    class Softlayer
      class Mock
        def get_upgrade_item_prices
          []
        end
      end
    end
  end
end