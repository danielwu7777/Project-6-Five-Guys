require 'finnhub_ruby'

puts "-- Instantiating Finnhub Client..."

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = 'cbb0nh2ad3i91bfqdnig'
end

::FinnhubClient = FinnhubRuby::DefaultApi.new