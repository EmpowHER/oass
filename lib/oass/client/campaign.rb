module Oass
  class Client
    module Campaign
      def read_campaign(id)
        request "Campaign" do |xml|
          xml.Campaign(:action => "read") do
            xml.Overview { xml.Id id }
          end
        end
      end

      def create_campaign(attributes)
        create_or_update_campaign("add", attributes)
      end

      def update_campaign(attributes)
        create_or_update_campaign("update", attributes)
      end

      private

      def create_or_update_campaign(action, attributes)
        request "Campaign" do |xml|
          xml.Campaign(:action => action) do
            xml.Overview do
              # Yeah... the attributes must be in the right order =/
              xml.Id attributes[:id]
              xml.AdvertiserId attributes[:advertiser_id] if attributes[:advertiser_id]
              xml.Name attributes[:name] if attributes[:name]
              xml.AgencyId attributes[:agency_id] if attributes[:agency_id]
              xml.Description attributes[:description] if attributes[:description]
              xml.CampaignManager attributes[:campaign_manager] if attributes[:campaign_manager]
              xml.ProductId attributes[:product_id]
              xml.Status attributes[:status] if attributes[:status]
              xml.ExternalUsers do
                attributes[:external_users].each do |user_id|
                  xml.UserId user_id
                end
              end if attributes[:external_users]
              xml.InternalQuickReport attributes[:internal_quick_report] if attributes[:internal_quick_report]
              xml.ExternalQuickReport attributes[:external_quick_report] if attributes[:external_quick_report]
            end

            if schedule = attributes[:schedule]
              xml.Schedule do
                xml.Impressions schedule[:impressions] if schedule[:impressions]
                xml.Clicks schedule[:clicks] if schedule[:clicks]
                xml.Uniques schedule[:uniques] if schedule[:uniques]
                xml.Weight schedule[:weight] if schedule[:weight]
                xml.PriorityLevel schedule[:priority_level] if schedule[:priority_level]
                xml.Completion schedule[:completion] if schedule[:completion]
                xml.StartDate schedule[:start_date] if schedule[:start_date]
                xml.EndDate schedule[:end_date] if schedule[:end_date]
                xml.Reach schedule[:reach] if schedule[:reach]
                xml.DailyImp schedule[:daily_impressions] if schedule[:daily_impressions]
                xml.DailyClicks schedule[:daily_clicks] if schedule[:daily_clicks]
                xml.DailyUniq schedule[:daily_uniq] if schedule[:daily_uniq]
                xml.SmoothOrAsap schedule[:smooth_or_asap] if schedule[:smooth_or_asap]
                xml.ImpOverrun schedule[:impression_overrun] if schedule[:impression_overrun]
                xml.CompanionPositions do
                  schedule[:companion_positions].each do |position|
                    xml.CompanionPosition position
                  end
                end if schedule[:companion_positions]
                xml.StrictCompanions schedule[:strict_companions] if schedule[:strict_companions]

                # TODO check the primary and secondary frequency errors
                if primary_frequency = schedule[:primary_frequency]
                  xml.PrimaryFrequency do
                    xml.ImpPerVisitor primary_frequency[:impression_per_visitor]
                    xml.ClickPerVisitor primary_frequency[:click_per_visitor]
                    xml.FreqScope primary_frequency[:frequency_scope]
                  end
                end

                if secondary_frequency = schedule[:primary_frequency]
                  xml.SecondaryFrequency do
                    xml.ImpPerVisitor secondary_frequency[:impression_per_visitor]
                    xml.FreqScope secondary_frequency[:frequency_scope]
                  end
                end

                xml.HourOfDay do
                  schedule[:hours_of_day].each do |hour|
                    xml.Hour hour
                  end
                end if schedule[:hours_of_day]

                xml.DayOfWeek do
                  schedule[:days_of_week].each do |day|
                    xml.Day day
                  end
                end if schedule[:days_of_week]

                xml.UserTimeZone schedule[:user_time_zone] if schedule[:user_time_zone]

                xml.Sections do
                  schedule[:sections].each do |section|
                    xml.SectionId section
                  end
                end if schedule[:sections]
              end
            end

            if pages = attributes[:pages]
              xml.Pages do
                pages.each do |page|
                  xml.Url page
                end
              end
            end
          end
        end
      end
    end

  end
end
