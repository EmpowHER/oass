module Oass
  class OASError < StandardError
    attr_reader :code

    def initialize(message, options = {})
      super message
      @code = options[:code]
    end
  end

  class NotFoundError < OASError; end
end
