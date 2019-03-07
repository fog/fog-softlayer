#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/softlayer/models/network/subnet'

module Fog
  module Softlayer
    class Network
      class Subnets < Fog::Collection
        attribute :filters

        model Fog::Softlayer::Network::Subnet

        def all
          load(service.list_subnets.body)
        end

        def get(id)
          if subnet = service.get_subnet(id).body
            new(subnet)
          end
        rescue Fog::Softlayer::Network::NotFound
          nil
        end
      end
    end
  end
end
