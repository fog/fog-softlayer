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

        # Reboots a BM server
        # @return [Excon::Response]
        def get_virtual_guest_create_options
          response = Excon::Response.new
          response.body = @virtual_guests
          response.status = 200
          response
        end
      end

      class Real

        def get_virtual_guest_create_options
          request(:virtual_guest, "getCreateObjectOptions", :http_method => :GET)
        end

      end
    end
  end
end
