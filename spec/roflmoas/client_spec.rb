require 'spec_helper'

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
end
