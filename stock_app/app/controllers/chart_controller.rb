require "finnhub_ruby"

class ChartController < ApplicationController

  FinnhubRuby.configure do |config|
    config.api_key['api_key'] = 'cbb0nh2ad3i91bfqdnig'
  end

  def show


    @finnhub_client = FinnhubRuby::DefaultApi.new
    @data =  puts(@finnhub_client.stock_candles('AAPL', 'D', 1590988249, 1591852249))
    
  end
end
