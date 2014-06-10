#
# Author:: Celso Fernandes (<fernandes@zertico.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#
require 'fog/core/collection'
require 'fog/softlayer/models/dns/record'

module Fog
  module DNS
    class Softlayer
      class Records < Fog::Collection
        attribute :domain

        model Fog::DNS::Softlayer::Record

        def all
          requires :domain
          clear
          data = service.get_records(domain.id).body
          load(data)
        end

        def new(attributes = {})
          requires :domain
          super({ :domain => domain }.merge!(attributes))
        end
      end
    end
  end
end