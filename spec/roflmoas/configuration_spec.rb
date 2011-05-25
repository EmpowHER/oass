require "spec_helper"

describe RoflmOAS do
  describe ".configure" do
    [:endpoint, :account, :username, :password].each do |setting|
      it "allows configuration for #{setting}" do
        expect { RoflmOAS.send("#{setting}=", "LOL") }.to change { RoflmOAS.send(setting) }.to("LOL")
      end
    end
  end
end
