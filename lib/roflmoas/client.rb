require 'savon'

module RoflmOAS
  class Client
    attr_accessor :endpoint, :account, :username, :password

    def initialize(options = {})
      options.reverse_merge! :endpoint => RoflmOAS.endpoint,
                             :account  => RoflmOAS.account,
                             :username => RoflmOAS.username,
                             :password => RoflmOAS.password

      options.each_pair do |key, value|
        send "#{key}=", value
      end
    end
  end
end
