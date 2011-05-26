require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash/reverse_merge'
require 'savon'
require 'oass/errors'

module Oass
  autoload :Client, "oass/client"
  autoload :Campaign, "oass/campaign"
  autoload :Creative, "oass/creative"

  mattr_accessor :endpoint
  @@endpoint = "https://training7.247realmedia.com//oasapi/OaxApi?wsdl"

  mattr_accessor :account
  @@account = "OasDefault"

  mattr_accessor :username

  mattr_accessor :password

  def self.configure
    yield self
  end
end
