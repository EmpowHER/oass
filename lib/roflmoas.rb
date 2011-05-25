require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash/reverse_merge'
require 'savon'
require 'roflmoas/errors'

module RoflmOAS
  autoload :Client, "roflmoas/client"

  mattr_accessor :endpoint
  @@endpoint = "https://training7.247realmedia.com//oasapi/OaxApi?wsdl"

  mattr_accessor :account
  @@account = "OasDefault"

  mattr_accessor :username, :password

  def configure
    yield self
  end
end
