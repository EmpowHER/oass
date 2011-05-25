module RoflmOAS
  module Campaign
    def read_campaign(id)
      request "Campaign" do |xml|
        xml.Campaign(:action => "read") do
          xml.Overview { xml.Id id }
        end
      end
    end
  end
end
