module RoflmOAS
  module Campaign
    def read_campaign(id)
      request "Campaign" do |xml|
        xml.Campaign(:action => "read") do
          xml.Overview { xml.Id id }
        end
      end
    end

    def create_campaign(attributes)
      request "Campaign" do |xml|
        xml.Campaign(:action => "add") do
          xml.Overview do
            # Yeah... the attributes must be in the right order =/
            xml.Id attributes[:id]
            xml.AdvertiserId attributes[:advertiser_id]
            xml.Name attributes[:name]
            xml.AgencyId attributes[:agency_id]
            xml.Description attributes[:description]
            xml.CampaignManager attributes[:campaign_manager]
            xml.ProductId attributes[:product_id]
            xml.ExternalUsers do
              attributes[:external_users].each do |user_id|
                xml.UserId user_id
              end
            end if attributes[:external_users]
            xml.InternalQuickReport attributes[:internal_quick_report]
            xml.ExternalQuickReport attributes[:external_quick_report]
          end
        end
      end
    end
  end
end
