require "spec_helper"

describe Oass::Client do
  context "configuration" do
    [:endpoint, :account, :username, :password].each do |setting|
      context "on initialization" do
        subject { Oass::Client.new setting => "WUT" }
        its(setting) { should == "WUT" }
      end

      context "after initialization" do
        subject { Oass::Client.new }
        before { subject.send("#{setting}=", "WUT") }
        its(setting) { should == "WUT" }
      end
    end
  end

  describe "#request" do
    use_vcr_cassette

    let(:client) { Oass::Client.new }

    context "successfully" do
      subject do
        client.request "Campaign" do |xml|
          xml.Campaign(:action => "read") do
            xml.Overview { xml.Id "abx_oferta3" }
          end
        end
      end

      it "finds the right campaign" do
        subject.css("Id").first.content.should == "abx_oferta3"
      end
    end

    context "unsuccessfully" do
      it "raises a OASError" do
        expect {
          client.request "Campaign" do |xml|
            xml.Campaign(:action => "read") do
              xml.Overview { xml.Id "invalid_id_lol" }
            end
          end
        }.to raise_error(Oass::OASError)
      end
    end
  end

  describe "#read_campaign" do
    use_vcr_cassette

    let(:client) { Oass::Client.new }

    context "with a valid id" do
      subject { client.read_campaign("abx_oferta3") }

      it "finds the right campaign" do
        subject.css("Id").first.content.should == "abx_oferta3"
      end
    end

    context "with an invalid id" do
      it "raises a NotFoundError" do
        expect { client.read_campaign("LOLWUT").to raise_error(Oass::NotFoundError) }
      end
    end
  end

  describe "#read_creative" do
    use_vcr_cassette

    let(:client) { Oass::Client.new }

    context "with a valid id" do
      subject { client.read_creative("abx_oferta3", "creatiewut") }

      it "finds the right creative" do
        subject.css("Id").first.content.should == "creatiewut"
      end
    end

    context "with an invalid id" do
      it "raises a NotFoundError" do
        expect { client.read_creative("abx_oferta3", "LOLWUT").to raise_error(Oass::NotFoundError) }
      end
    end

    context "with an invalid campaign id" do
      it "raises a NotFoundError" do
        expect { client.read_creative("LOLWUT", "creatiewut").to raise_error(Oass::NotFoundError) }
      end
    end
  end

  describe "#create_campaign" do
    use_vcr_cassette

    let(:client) { Oass::Client.new }

    context "with just the required attributes" do
      let(:attributes) do
        {
          :id => ("a".."z").to_a.shuffle.join,
          :name => "LOLWUT",
          :advertiser_id => "bobo",
          :agency_id => "unknown_agency",
          :product_id => "default-product",
          :schedule => {
            :impressions => 999,
            :clicks => 0,
            :completion => "S",
            :priority_level => 1,
            :reach => "O",
            :smooth_or_asap => "S",
          }
        }
      end

      subject { client.create_campaign attributes }

      its(:content) { should == "Successfully added." }
    end

    context "with valid attributes" do
      let(:attributes) do
        {
          :id => ("a".."z").to_a.shuffle.join,
          :name => "LOLWUT",
          :advertiser_id => "bobo",
          :agency_id => "unknown_agency",
          :name => "LOLWUT",
          :campaign_manager => "lol",
          :product_id => "default-product",
          :description => "lolwut",
          :internal_quick_report => "short",
          :external_quick_report => "short",
          :schedule => {
            :impressions => 999,
            :clicks => 0,
            :uniques => 0,
            :weight => 10,
            :priority_level => 1,
            :completion => "E",
            :start_date => "2005-12-01",
            :end_date => "2040-12-01",
            :reach => "O",
            :daily_impressions => 99,
            :daily_clicks => 9,
            :daily_uniq => 1,
            :smooth_or_asap => "S",
            :impression_overrun => 2,
            :companion_positions => %w(B/T BL/TL),
            :strict_companions => "Y",
            :hours_of_day => %w(00 01 23),
            :days_of_week => %w(2 3 4 5),
            :user_time_zone => "Y",
            :sections => %w(SectionABC SectionDEF)
          }
        }
      end

      subject { client.create_campaign attributes }

      its(:content) { should == "Successfully added." }
    end

    context "with invalid attributes" do
      use_vcr_cassette "Invalid campaign movie"

      it "raises an OasError" do
        expect { client.create_campaign :invalid => true }.to raise_error(Oass::OASError)
      end
    end
  end

  describe "#create_creative" do
    use_vcr_cassette

    let(:client) { Oass::Client.new }

    context "with valid attributes" do
      let(:attributes) do
        {
          :campaign_id => "random_id_lolwut",
          :id => "I_am_so_creative_lolwut",
          :name => "A nice name indeed",
          :description => "Blabla",
          :click_url => "http://lolwut.com",
          :positions => %w(TopLeft BottomLeft),
          :creative_types_id => "unknow_type",
          :redirect_url => "http://lolwut.com",
          :display => "Y",
          :height => "30",
          :width => "30",
          :target_window => "targetwindow",
          :alt_text => "Oh hai!",
          :discount_impressions => "N",
          :start_date => "1986-03-31",
          :end_date => "2040-03-31",
          :weight => "79",
          :expire_immediately => "N",
          :no_cache => "N",
          :extra_html => "<b></b>",
          :extra_text => "kthxbai",
          :browser_versions => %w(explorer6 netscape7),
          :sequence_number => "4"
        }
      end

      subject { client.create_creative attributes }

      its(:content) { should == "Successfully added." }
    end

    context "with a creative file" do
      use_vcr_cassette :record => :once

      let(:attributes) do
        {
          :campaign_id => "random_id_lolwut",
          :id => "creative_with_a_creative_lol",
          :name => "A nice name indeed",
          :description => "Blabla",
          :click_url => "http://lolwut.com",
          :positions => %w(TopLeft BottomLeft),
          :creative_types_id => "unknow_type",
          :redirect_url => "http://lolwut.com",
          :display => "Y",
          :height => "30",
          :width => "30",
          :target_window => "targetwindow",
          :alt_text => "Oh hai!",
          :discount_impressions => "N",
          :start_date => "1986-03-31",
          :end_date => "2040-03-31",
          :weight => "79",
          :expire_immediately => "N",
          :no_cache => "N",
          :extra_html => "<b></b>",
          :extra_text => "kthxbai",
          :browser_versions => %w(explorer6 netscape7),
          :sequence_number => "4",
          :creative_file => {
            :name => "image.png",
            :content_type => "image/png",
            :file => File.join(File.dirname(__FILE__), "../fixtures/creative_file.png")
          }
        }
      end

      subject { client.create_creative attributes }

      its(:content) { should == "Successfully added." }
    end

    context "with a component file" do
      use_vcr_cassette :record => :once

      let(:attributes) do
        {
          :campaign_id => "random_id_lolwut",
          :id => "creative_with_a_component_lol",
          :name => "A nice name indeed",
          :description => "Blabla",
          :click_url => "http://lolwut.com",
          :positions => %w(TopLeft BottomLeft),
          :creative_types_id => "unknow_type",
          :redirect_url => "http://lolwut.com",
          :display => "Y",
          :height => "30",
          :width => "30",
          :target_window => "targetwindow",
          :alt_text => "Oh hai!",
          :discount_impressions => "N",
          :start_date => "1986-03-31",
          :end_date => "2040-03-31",
          :weight => "79",
          :expire_immediately => "N",
          :no_cache => "N",
          :extra_html => "<b></b>",
          :extra_text => "kthxbai",
          :browser_versions => %w(explorer6 netscape7),
          :sequence_number => "4",
          :component_file => {
            :name => "image.png",
            :content_type => "image/png",
            :file => File.join(File.dirname(__FILE__), "../fixtures/creative_file.png")
          }
        }
      end

      subject { client.create_creative attributes }

      its(:content) { should == "Successfully added." }
    end

    context "with invalid attributes" do
      use_vcr_cassette "Invalid creative movie"

      it "raises an OasError" do
        expect { client.create_creative :invalid => true }.to raise_error(Oass::OASError)
      end
    end
  end
end
