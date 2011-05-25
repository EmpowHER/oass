require "spec_helper"

describe RoflmOAS::Client do
  context "configuration" do
    [:endpoint, :account, :username, :password].each do |setting|
      context "on initialization" do
        subject { RoflmOAS::Client.new setting => "WUT" }
        its(setting) { should == "WUT" }
      end

      context "after initialization" do
        subject { RoflmOAS::Client.new }
        before { subject.send("#{setting}=", "WUT") }
        its(setting) { should == "WUT" }
      end
    end
  end

  describe "#request" do
    use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method, :body]

    let(:client) { RoflmOAS::Client.new }

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
        }.to raise_error(RoflmOAS::OASError)
      end
    end
  end

  describe "#read_campaign" do
    use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method, :body]

    let(:client) { RoflmOAS::Client.new }

    context "with a valid id" do
      subject { client.read_campaign("abx_oferta3") }

      it "finds the right campaign" do
        subject.css("Id").first.content.should == "abx_oferta3"
      end
    end

    context "with an invalid id" do
      it "raises a NotFoundError" do
        expect { client.read_campaign("LOLWUT").to raise_error(RoflmOAS::NotFoundError) }
      end
    end
  end

  describe "#read_creative" do
    use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method, :body]

    let(:client) { RoflmOAS::Client.new }

    context "with a valid id" do
      subject { client.read_creative("abx_oferta3", "creatiewut") }

      it "finds the right creative" do
        subject.css("Id").first.content.should == "creatiewut"
      end
    end

    context "with an invalid id" do
      it "raises a NotFoundError" do
        expect { client.read_creative("abx_oferta3", "LOLWUT").to raise_error(RoflmOAS::NotFoundError) }
      end
    end

    context "with an invalid campaign id" do
      it "raises a NotFoundError" do
        expect { client.read_creative("LOLWUT", "creatiewut").to raise_error(RoflmOAS::NotFoundError) }
      end
    end
  end

  describe "#create_campaign" do
    use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method, :body]

    let(:client) { RoflmOAS::Client.new }

    context "with the required attributes" do
      let(:attributes) do
        {
          :id => "random_id_lolwut_wtf",
          :name => "LOLWUT",
          :advertiser_id => "bobo",
          :agency_id => "unknown_agency",
          :name => "LOLWUT",
          :campaign_manager => "lol",
          :product_id => "default-product",
        }
      end

      subject { client.create_campaign attributes }

      its(:content) { "Successfully added." }
    end
  end
end
