module RoflmOAS
  module Creative
    def read_creative(campaign_id, id)
      request "Creative" do |xml|
        xml.Creative(:action => "read") do
          xml.CampaignId campaign_id
          xml.Id id
        end
      end
    end
  end
end
