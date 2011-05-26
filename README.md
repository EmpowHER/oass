# O_ass_
Oass is a library to help you to interact with OAS and its bizarre soap API.

## Installation
    gem install oass

## Configuration
Add global configurations directly to the Oass module:

    Oass.configure do |config|
      config.endpoint = "The wsdl endpoint"
      config.account  = "Your OAS account"
      config.username = "LOL"
      config.password = "WUT"
    end

You can override any settings when you instantiate a new client

    client = Oass::Client.new :username => "Other", :password => "Secret"

## Usage
    client = Oass::Client.new
    campaign = client.read_campaign("campaign_id")

You can create new resources by informing its properties as a hash in underscore_case

    client.create_campaign :id => "Campaign!", :description => "Oh hai!"

To upload files (for example, the creative and component files) you don't need to worry about enconding stuff, just specify their paths, types and name

    client.create_creative :creative_file => { :name => "trollface.png", :content_type => "image/png", :file => "/path/to/trollface.png" }

You can also make requests that are not yet natively implemented

    client.request "Campaign" do |xml|
      xml.Campaign(:action => "list") do
        xml.SearchCriteria do
          xml.Status "L"
        end
      end
    end
