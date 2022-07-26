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
  stock_hash = {}


  msg_json['data'].each { |entry|  stock_hash[entry['s']] = entry['p']  }

  #msg_stock = msg_json['data'][0]['s']
  msg_time = msg_json['data'][0]['t'].to_i
  if msg_time - prev_msg_time > 3000
    #new_price = msg_json['data'][0]['p'].to_f
    stock_hash.each_pair{|ticker,price|StocksController.price_change ticker, price }
    prev_msg_time = msg_time
  end
end

StockSocket.on :open do
  puts "-- websocket open (#{StockSocket.url})"
  StockSocket.send('{"type":"subscribe","symbol":"BINANCE:BTCUSDT"}')
  StockSocket.send('{"type":"subscribe","symbol":"GOOGL"}')
end

StockSocket.on :close do |e|
  puts "-- websocket close (#{e.inspect})"
end

StockSocket.on :error do |e|
  puts "-- error (#{e.inspect})"
end