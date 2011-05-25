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
            xml.Id attributes.delete(:id)
            xml.AdvertiserId attributes.delete(:advertiser_id)
            xml.Name attributes.delete(:name)
            xml.AgencyId attributes.delete(:agency_id)
            xml.Description attributes.delete(:description)
            xml.CampaignManager attributes.delete(:campaign_manager)
            xml.ProductId attributes.delete(:product_id)
            xml.ExternalUsers do
              attributes.delete(:external_users).each do |user_id|
                xml.UserId user_id
              end
            end if attributes[:external_users]
            xml.InternalQuickReport attributes.delete(:internal_quick_report)
            xml.ExternalQuickReport attributes.delete(:external_quick_report)
          end
        end
      end
    end
  end
end
