require 'websocket-client-simple'

::StockSocket = WebSocket::Client::Simple.connect 'wss://ws.finnhub.io?token=cbb0nh2ad3i91bfqdnig'
StockSocket.on :message do |msg|
  puts msg.data
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