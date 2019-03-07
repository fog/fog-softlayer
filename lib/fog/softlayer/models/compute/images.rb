#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/softlayer/models/compute/image'

module Fog
  module Softlayer
    class Compute

      class Images < Fog::Collection

        model Fog::Softlayer::Compute::Image

        # Returns an array of all public images.
        #
        # Fog::Softlayer.images.all
        def all
          load(service.request(:virtual_guest_block_device_template_group, :get_public_images).body)
          self
        end

        # Returns an array of all private images for current account.
        def private
          load(service.request(:account, :getPrivateBlockDeviceTemplateGroups).body)
          self
        end

        # Used to retrieve an image
        def get(uuid)
          self.class.new(:service => service).all.detect {|image| image.id == uuid}
        end

      end

    end
  end
end
