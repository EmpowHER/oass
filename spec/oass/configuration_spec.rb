require "spec_helper"

describe Oass do
  describe ".configure" do
    [:endpoint, :account, :username, :password].each do |setting|
      it "allows configuration for #{setting}" do
        expect { Oass.send("#{setting}=", "LOL") }.to change { Oass.send(setting) }.to("LOL")
      end

      it "provides #{setting} in the configuration block" do
        expect {
          Oass.configure { |config|
            config.send("#{setting}=", "WUT")
          }
        }.to change { Oass.send(setting) }.to("WUT")
      end
    end
  end
end
