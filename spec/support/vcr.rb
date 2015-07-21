require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].gsub('::', '/').gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name, {}, &example)
  end
end

WebMock.allow_net_connect!

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/vcr'
  c.default_cassette_options = { record: :new_episodes,
                                 match_requests_on: [:method, :path, :query, :body] }
end
