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
        # Gets all Bare Metal active tickets
        # @param [Integer] id
        # @return [Excon::Response]
        def get_bare_metal_active_tickets(id)
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
            response.body = []
          end
          response
        end
      end

      class Real
        def get_bare_metal_active_tickets(id)
          request(:hardware_server, "#{id.to_s}/getActiveTickets", :http_method => :GET)
        end
      end
    end
  end
end