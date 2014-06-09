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
        def get_domain
          response = Excon::Response.new
          response.body = @domains
          response.status = 200
          response
        end

      end

      class Real
        def get_domain(id)
          request(:dns_domain, id)
        end
      end
    end
  end
end
