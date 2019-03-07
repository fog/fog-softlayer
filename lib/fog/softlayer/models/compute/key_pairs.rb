#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/softlayer/models/compute/key_pair'

module Fog
  module Softlayer
    class Compute
      class KeyPairs < Fog::Collection
        model Fog::Softlayer::Compute::KeyPair

        def all
          data = service.get_key_pairs.body
          load(data)
        end

        def get(id)
          if key_pair = service.get_key_pair(id).body
            new(key_pair)
          end
        rescue Fog::Softlayer::Network::NotFound
          nil
        end

        def by_label(label)
          all.select { |key_pair| key_pair.label == label }.first
        end

      end
    end
  end
end
