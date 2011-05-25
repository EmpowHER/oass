module Oass
  module Creative
    def read_creative(campaign_id, id)
      request "Creative" do |xml|
        xml.Creative(:action => "read") do
          xml.CampaignId campaign_id
          xml.Id id
        end
      end
    end

    def create_creative(attributes)
      request "Creative" do |xml|
        xml.Creative(:action => "add") do
          xml.CampaignId attributes[:campaign_id]
          xml.Id attributes[:id]
          xml.Name attributes[:name]
          xml.Description attributes[:description]
          xml.ClickUrl attributes[:click_url]
          xml.Positions do
            attributes[:positions].each do |position|
              xml.Position position
            end
          end
          xml.CreativeTypesId attributes[:creative_types_id]
          xml.RedirectUrl attributes[:redirect_url]
          xml.Display attributes[:display]
          xml.Height attributes[:height]
          xml.Width attributes[:width]
          xml.TargetWindow attributes[:target_window]
          xml.AltText attributes[:alt_text]
          xml.DiscountImpressions attributes[:discount_impressions]
          xml.StartDate attributes[:start_date]
          xml.EndDate attributes[:end_date]
          xml.Weight attributes[:weight]
          xml.ExpireImmediately attributes[:expire_immediately]
          xml.NoCache attributes[:no_cache]
          xml.ExtraHTML attributes[:extra_html]
          xml.ExtraText attributes[:extra_text]
          xml.BrowserV do
            attributes[:browser_versions].each do |version|
              xml.Code version
            end
          end
          xml.SequenceNo attributes[:sequence_number]
        end
      end
    end
  end
end
