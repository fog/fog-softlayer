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
        def get_records
          response = Excon::Response.new
          response.body = @domains
          response.status = 200
          response
        end

      end

      class Real
        def get_records(domain_id)
          request(:dns_domain, domain_id.to_s + '/getResourceRecords')
        end
      end
    end
  end
end
