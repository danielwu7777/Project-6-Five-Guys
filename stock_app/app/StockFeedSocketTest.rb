#Dont know what to do with this yet but it works
ws = WebSocket::Client::Simple.connect 'wss://ws.finnhub.io?token=cbb0nh2ad3i91bfqdnig'
ws.on :message do |msg|

end

ws.on :open do
  puts "-- websocket open (#{ws.url})"
  ws.send('{"type":"subscribe","symbol":"AAPL"}')
end

ws.on :close do |e|
  puts "-- websocket close (#{e.inspect})"
  exit 1
end

ws.on :error do |e|
  puts "-- error (#{e.inspect})"
end
