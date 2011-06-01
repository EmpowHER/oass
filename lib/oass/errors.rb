module Oass
  class OASError < StandardError
    attr_accessor :code

    def initialize(message, options = {})
      super(message)
      @code = options[:code]
    end
  end

  class NotFoundError < OASError; end
end
