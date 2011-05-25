require 'active_support/core_ext/module/attribute_accessors'

module RoflmOAS
  mattr_accessor :endpoint
  @@endpoint = "https://training7.247realmedia.com//oasapi/OaxApi?wsdl"

  mattr_accessor :account
  @@account = "OasDefault"

  mattr_accessor :username, :password

  def configure
    yield self
  end
end
