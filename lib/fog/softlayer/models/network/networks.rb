#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/softlayer/models/network/network'

module Fog
  module Network
    class Softlayer
      class Networks < Fog::Collection
        model Fog::Network::Softlayer::Network

        def all
          data = service.list_networks.body
          load(data)
        end

        def get(id)
          if network = service.get_network(id).body
            new(network)
          end
        rescue Fog::Network::Softlayer::NotFound
          nil
        end
      end
    end
  end
end
