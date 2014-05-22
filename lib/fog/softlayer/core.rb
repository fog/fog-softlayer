#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#
require 'fog/core'
require 'fog/json'
require 'time'

module Fog
  module Softlayer
    extend Fog::Provider

    SL_API_URL = 'api.softlayer.com/rest/v3' unless defined? SL_API_URL
    SL_STORAGE_AUTH_URL = 'objectstorage.softlayer.net/auth/v1.0' unless defined? SL_STORAGE_AUTH_URL

    service(:compute, 'Compute')
    service(:storage, 'Storage')

    def self.mock_account_id
      Fog.mocking? and @sl_account_id ||= Fog::Mock.random_numbers(7)
    end

    def self.mock_vm_id
      Fog::Mock.random_numbers(7)
    end

    def self.mock_global_identifier
      Fog::UUID.uuid
    end

    def self.valid_request?(required, passed)
      required.all? {|k| k = k.to_sym; passed.key?(k) and !passed[k].nil?}
    end

    # CGI.escape, but without special treatment on spaces
    def self.escape(str,extra_exclude_chars = '')
      str.gsub(/([^a-zA-Z0-9_.-#{extra_exclude_chars}]+)/) do
        '%' + $1.unpack('H2' * $1.bytesize).join('%').upcase
      end
    end
  end
end
