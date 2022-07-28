# Created 7/25/22 by Yuhao Yan
# Edited 2/26/2022 by Yuhao Yan
# Edited 2/27/2022 by Yuhao Yan
require "finnhub_ruby"
require 'json'
require 'date'

class ChartController < ApplicationController

  FinnhubRuby.configure do |config|
    config.api_key['api_key'] = 'cbb0nh2ad3i91bfqdnig'
  end

  def show
    @stock = Stock.find(params[:id])

    @finnhub_client = FinnhubRuby::DefaultApi.new

    date = Date.today 
    date.to_time.to_i
    
    @data =  @finnhub_client.stock_candles(@stock.ticker, 'D', (date - 31).to_time.to_i, date.to_time.to_i).o
    @chart_data = []

    @data.each_index { |index| 
      @chart_data << [date.to_s, @data[index]]
      date = date + 1
   }
      
  end

end
