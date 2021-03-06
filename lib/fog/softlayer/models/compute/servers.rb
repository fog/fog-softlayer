#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/softlayer/models/compute/server'

module Fog
  module Softlayer
    class Compute

      class Servers < Fog::Collection

        model Fog::Softlayer::Compute::Server

        def all
          data = service.list_servers
          load(data)
        end

        ## Get a SoftLayer server.
        #

        def get(identifier)
          return nil if identifier.nil? || identifier == ""
          response = service.get_vm(identifier)
          bare_metal = false
          if response.status == 404 # we didn't find it as a VM, look for a BMC server
            response = service.get_bare_metal_server(identifier)
            bare_metal = true
          end
          data = response.body
          data['bare_metal'] = bare_metal
          new.merge_attributes(data)
        rescue Excon::Errors::NotFound
          nil
        end

        ## Get a SoftLayer server by ip.
        #
        def get_by_ip(ip)
          return nil if ip.blank?
          response = service.get_virtual_guest_by_ip(ip)
          bare_metal = false
          if response.status == 404 # we didn't find it as a VM, look for a BMC server
            response = service.get_bare_metal_server_by_ip(ip)
            bare_metal = true
          end
          data = response.body
          data['bare_metal'] = bare_metal
          new.merge_attributes(data)
        rescue Excon::Errors::NotFound
          nil
        end

        def bootstrap(options={})
          server = service.create(options)
          server.wait_for { ready? }
          server
        end

        def tagged_with(tags)
          raise ArgumentError, "Tags argument for #{self.class.name}##{__method__} must be Array." unless tags.is_a?(Array)
          ids = service.get_references_by_tag_name(tags.join(',')).body.map do |tag|
            tag['references'].map do |ref|
              ref['resourceTableId']
            end
          end.flatten.uniq
          ids.map { |id| get(id) }
        end
        
        def get_bm_create_options
          service.get_bare_metal_create_options.body
        end

        def get_vm_create_options
          service.get_virtual_guest_create_options.body
        end

        def get_available_preset_codes
          service.get_available_preset_codes.body['fixedConfigurationPresets'].map { |item| { :desc => item['preset']['description'], :key => item['preset']['keyName'] } }
        end
      end
    end
  end
end
