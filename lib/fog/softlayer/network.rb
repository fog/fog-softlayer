#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/softlayer/core'

module Fog
  module Network
    class Softlayer < Fog::Service

      requires :softlayer_username, :softlayer_api_key


      ## MODELS
      #
      model_path 'fog/softlayer/models/network'
      model       :datacenter
      collection  :datacenters
      model       :network
      collection  :networks
      #model       :port
      #collection  :ports
      model       :subnet
      collection  :subnets
      model       :ip
      collection  :ips
      model       :tag
      collection  :tags
      #model       :router
      #collection  :routers


      ## REQUESTS
      #
      request_path 'fog/softlayer/requests/network'

      request :list_networks
      request :create_network
      request :delete_network
      request :get_network
      #request :update_network

      request :get_private_vlan_price_code
      request :get_public_vlan_price_code
      request :get_subnet_package_id
      request :get_subnet_price_code
      request :get_datacenters
      request :get_datacenter_routers


      request :create_network_tags
      request :delete_network_tags
      request :get_network_tags

      #request :list_ports
      #request :create_port
      #request :delete_port
      #request :get_port
      #request :update_port

      request :list_subnets
      #request :create_subnet
      #request :delete_subnet
      request :get_subnet
      #request :update_subnet

      #request :list_ip_addresses
      #request :create_ip_addresse
      #request :delete_ip_addresse
      request :get_ip_address
      #request :associate_ip_address
      #request :disassociate_ip_address

      class Mock
        #Fog::Mock.random_ip,

        def self.reset
          @data = nil
        end

        def initialize(options={})
          @softlayer_api_key = options[:softlayer_api_key]
          @softlayer_username = options[:softlayer_username]

          @networks = []
          @datacenters = [
              {"id"=>265592, "longName"=>"Amsterdam 1", "name"=>"ams01"},
              {"id"=>358698, "longName"=>"Ashburn, VA 3", "name"=>"wdc03"},
              {"id"=>3, "longName"=>"Dallas 1", "name"=>"dal01"},
              {"id"=>154770, "longName"=>"Dallas 2", "name"=>"dal02"},
              {"id"=>167092, "longName"=>"Dallas 4", "name"=>"dal04"},
              {"id"=>138124, "longName"=>"Dallas 5", "name"=>"dal05"},
              {"id"=>154820, "longName"=>"Dallas 6", "name"=>"dal06"},
              {"id"=>142776, "longName"=>"Dallas 7", "name"=>"dal07"},
              {"id"=>352494, "longName"=>"Hong Kong 2", "name"=>"hkg02"},
              {"id"=>142775, "longName"=>"Houston 2", "name"=>"hou02"},
              {"id"=>358694, "longName"=>"London 2", "name"=>"lon02"},
              {"id"=>168642, "longName"=>"San Jose 1", "name"=>"sjc01"},
              {"id"=>18171, "longName"=>"Seattle", "name"=>"sea01"},
              {"id"=>224092, "longName"=>"Singapore 1", "name"=>"sng01"},
              {"id"=>448994, "longName"=>"Toronto 1", "name"=>"tor01"},
              {"id"=>37473, "longName"=>"Washington, DC 1", "name"=>"wdc01"}
          ]
          @tags = []
        end

        def credentials
          { :provider           => 'softlayer',
            :softlayer_username => @softlayer_username,
            :softlayer_api_key  => @softlayer_api_key
          }
        end
      end

      class Real
        include Fog::Softlayer::Slapi

        def initialize(options={})
          @softlayer_api_key = options[:softlayer_api_key]
          @softlayer_username = options[:softlayer_username]
        end

        def request(service, path, options = {})
          options = {:username => @softlayer_username, :api_key => @softlayer_api_key}.merge(options)
          Fog::Softlayer::Slapi.slapi_request(service, path, options)
        end

        def list_networks
          self.list_networks
        end

      end
    end
  end
end
