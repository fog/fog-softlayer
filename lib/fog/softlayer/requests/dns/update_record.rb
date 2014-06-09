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
        def update_record(record_id, opts)
          response = Excon::Response.new
          response.body = @domains
          response.status = 200
          response
        end

      end

      class Real
        def update_record(record_id, opts)
          request(:dns_domain_resourceRecord, record_id, :body => opts, :http_method => :PUT)
        end
      end
    end
  end
end
