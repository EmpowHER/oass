require 'oass'
require 'vcr'

VCR.config do |config|
  config.cassette_library_dir = File.join("spec/fixtures/vcr_cassettes")
  config.stub_with :webmock
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
