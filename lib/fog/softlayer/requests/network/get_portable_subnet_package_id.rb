#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

module Fog
  module Softlayer
    class Network

      class Mock

        def get_portable_subnet_package_id(address_space)
          address_space.downcase!; err_msg = "Argument for #{self.class.name}##{__method__} must be 'PRIVATE' or 'PUBLIC'."
          raise ArgumentError, err_msg unless %{private public}.include?(address_space)
          42
        end

      end

      class Real
        def get_portable_subnet_package_id(address_space)
          address_space.downcase!; err_msg = "Argument for #{self.class.name}##{__method__} must be 'PRIVATE' or 'PUBLIC'."
          raise ArgumentError, err_msg unless %{private public}.include?(address_space)
          request(:product_package, '0/get_configuration', :query => 'objectMask=mask[isRequired,itemCategory]').body.map do |item|
            item['itemCategory']['id'] if item['itemCategory']['categoryCode'] == "sov_sec_ip_addresses_#{address_space == 'public' ? 'pub' : 'priv'}"
          end.compact.first
        end
      end
    end
  end
end
