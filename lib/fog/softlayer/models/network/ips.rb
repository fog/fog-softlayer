#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/softlayer/models/network/ip'

module Fog
  module Network
    class Softlayer
      class Ips < Fog::Collection
        attribute :filters

        model Fog::Network::Softlayer::Ip

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters = filters)
          self.filters = filters
          load(service.list_ips(filters).body)
        end

        def get(id)
          if ip = service.get_ip_address(id).body
            new(ip)
          end
        rescue Fog::Network::Softlayer::NotFound
          nil
        end
      end
    end
  end
end
