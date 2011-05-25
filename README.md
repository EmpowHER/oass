# Lets ROFL!
RoflOAS is a library to help you to interact with OAS and their strange soap API.

## Installation
    gem install roflmoas

## Configuration
Add global configurations directly to the RoflmOAS module:

    RoflmOAS.configure do |config|
      config.endpoint = "The wsdl endpoint"
      config.account  = "Your OAS account"
      config.username = "LOL"
      config.password = "WUT"
    end

You can override any settings when you instantiate a new client

    client = RoflmOAS::Client.new :username => "Other", :password => "Secret"

## Usage
    client = RoflmOAS::Client.new
    campaign = client.read_campaign("campaign_id")

You can also make requests that are not yet natively implemented

    client.request "Campaign" do |xml|
      xml.Campaign(:action => "list") do
        xml.SearchCriteria do
          xml.Status "L"
        end
      end
    end
