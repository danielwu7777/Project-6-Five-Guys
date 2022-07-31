#Created by Jake McCann 7/21/2022

require 'websocket-client-simple'
require_relative '../../app/controllers/stocks_controller'
require 'json'

::StockSocket = WebSocket::Client::Simple.connect 'wss://ws.finnhub.io?token=cbb0nh2ad3i91bfqdnig'
prev_msg_time = 0
stock_hash = {}

StockSocket.on :message do |msg|
  msg_json = JSON.parse(msg.data)

  # Pings are occasionally sent, don't want exceptions happening
  return unless msg_json || msg_json['data']

  msg_json['data'].each { |entry| stock_hash[entry['s']] = entry['p']  }

  msg_time = msg_json['data'][0]['t'].to_i
  if msg_time - prev_msg_time > 5000
    stock_hash.each_pair{|ticker,price|StocksController.price_change ticker, price }
    prev_msg_time = msg_time
  end
end

StockSocket.on :open do
  puts "-- websocket open (#{StockSocket.url})"
  StockSocket.send('{"type":"subscribe","symbol":"BINANCE:BTCUSDT"}')
  sleep(1)
  StockSocket.send('{"type":"subscribe","symbol":"GOOGL"}')
  sleep(1)
  StockSocket.send('{"type":"subscribe","symbol":"AAPL"}')
  sleep(1)
  StockSocket.send('{"type":"subscribe","symbol":"AMD"}')
  sleep(1)
  StockSocket.send('{"type":"subscribe","symbol":"NVDA"}')
  sleep(1)
  StockSocket.send('{"type":"subscribe","symbol":"BINANCE:ETHUSDT"}')
  sleep(1.5)
end

StockSocket.on :close do |e|
  puts "-- websocket close (#{e.inspect})"
end

StockSocket.on :error do |e|
  puts "-- error (#{e.inspect})"
end