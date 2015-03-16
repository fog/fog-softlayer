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
        # Gets all Virtual Guest active tickets
        # @param [Integer] id
        # @return [Excon::Response]
        def get_virtual_guest_active_tickets(id)
          response = Excon::Response.new
          found = self.get_vms.body.map{|server| server['id']}.include?(id)
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
        def get_virtual_guest_active_tickets(id)
          request(:virtual_guest, "#{id.to_s}/getActiveTickets", :http_method => :GET)
        end
      end
    end
  end
end