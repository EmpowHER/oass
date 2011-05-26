require 'oass'
require 'vcr'

Dir[File.join("spec/support/**/*.rb")].each { |f| require f }

VCR.config do |config|
  config.cassette_library_dir = File.join("spec/fixtures/vcr_cassettes")
  config.stub_with :webmock
  config.default_cassette_options = {
    :record => :new_episodes,
    :match_requests_on => [:uri, :method, :body],
    :erb => { :username => ENV["OAS_USERNAME"], :password => ENV["OAS_PASSWORD"], :account => ENV["OAS_ACCOUNT"] }
  }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
