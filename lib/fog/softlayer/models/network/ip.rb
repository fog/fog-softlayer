#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/model'

module Fog
  module Network
    class Softlayer
      class Ip < Fog::Model
        identity :id

        attribute :subnet_id,             :aliases => 'subnetId'
        attribute :address,               :aliases => 'ipAddress'
        attribute :broadcast,            :aliases => 'isBroadcast'
        attribute :gateway,              :aliases => 'isGateway'
        attribute :network,              :aliases => 'isNetwork'
        attribute :reserved,             :aliases => 'isReserved'
        attribute :note
        attribute :assigned_to,           :aliases => ['hardware', 'virtualGuest']

        def initialize(attributes)
          @connection = attributes[:connection]
          super
        end

        def save
          requires :subnet_id
          identity ? update : create
        end

        def create

        end

        def update
          self
        end

        def destroy
          requires :id
          true
        end

        def broadcast?
          attribute[:broadcast]
        end

        def gateway?
          attribute[:gateway]
        end

        def network?
          attribute[:network]
        end

        def reserved?
          attribute[:reserved]
        end

      end
    end
  end
end
