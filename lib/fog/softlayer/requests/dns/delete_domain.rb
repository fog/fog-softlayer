#
# Author:: Celso Fernandes (<fernandes@zertico.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#
module Fog
  module DNS
    class Softlayer

      class Mock
        def delete_domain
          response = Excon::Response.new
          response.body = @domains
          response.status = 200
          response
        end

      end

      class Real
        def delete_domain(id)
          request(:dns_domain, id.to_s, :http_method => :DELETE)
        end
      end
    end
  end
end
