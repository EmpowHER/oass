module Oass
  class Client
    autoload :Campaign, "oass/client/campaign"
    autoload :Creative, "oass/client/creative"

    include Campaign
    include Creative

    attr_accessor :endpoint, :account, :username, :password

    def initialize(options = {})
      options.reverse_merge! :endpoint => Oass.endpoint,
                             :account  => Oass.account,
                             :username => Oass.username,
                             :password => Oass.password

      options.each_pair do |key, value|
        send "#{key}=", value
      end
    end

    def request(method)
      body = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.AdXML do
          xml.Request(:type => method) do
            yield xml
          end
        end
      end

      response = Savon::Client.new(endpoint).request :n1, :oas_xml_request, :"xmlns:n1" => "http://api.oas.tfsm.com/" do
        soap.body = {
          "String_1" => account,
          "String_2" => username,
          "String_3" => password,
          "String_4" => body.to_xml
        }
      end

      parse(response)
    end

    protected

    def parse(response)
      response = Nokogiri::XML.parse(response.to_hash[:oas_xml_request_response][:result])
      raise_errors(response)
      response.css("AdXML > Response > *").first
    end

    def raise_errors(response)
      return if (error = response.css("Exception")).empty?

      code    = error.attribute("errorCode").value.to_i
      message = error.first.content

      case code
        when 545
          raise Oass::NotFoundError.new message, :code => code
        else
          raise Oass::OASError.new message, :code => code
        end
    end
  end
end
