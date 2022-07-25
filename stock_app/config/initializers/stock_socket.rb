#Created by Jake McCann 7/21/2022

require 'websocket-client-simple'
require_relative '../../app/controllers/stocks_controller'
require 'json'

::StockSocket = WebSocket::Client::Simple.connect 'wss://ws.finnhub.io?token=cbb0nh2ad3i91bfqdnig'
prev_msg_time = 0

StockSocket.on :message do |msg|
  msg_json = JSON.parse(msg.data)
  # Pings are occasionally sent, don't want exceptions happening
  return if msg_json.nil? || msg_json['data'].nil?

  msg_stock = msg_json['data'][0]['s']
  msg_time = msg_json['data'][0]['t'].to_i
  if msg_time - prev_msg_time > 1000
    stock_record = Stock.find_by ticker: msg_stock
    stock_record.price = msg_json['data'][0]['p'].to_f
    StocksController.price_change msg_stock, stock_record.price
    prev_msg_time = msg_time
  end
end

StockSocket.on :open do
  puts "-- websocket open (#{StockSocket.url})"
  StockSocket.send('{"type":"subscribe","symbol":"BINANCE:BTCUSDT"}')
end

StockSocket.on :close do |e|
  puts "-- websocket close (#{e.inspect})"
end

StockSocket.on :error do |e|
  puts "-- error (#{e.inspect})"
end