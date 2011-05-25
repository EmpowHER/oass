require "spec_helper"

describe Oass do
  describe ".configure" do
    [:endpoint, :account, :username, :password].each do |setting|
      it "allows configuration for #{setting}" do
        expect { Oass.send("#{setting}=", "LOL") }.to change { Oass.send(setting) }.to("LOL")
      end
    end
  end
end
