require 'net/http'
require 'json'

def get_weather(city_name, api_key)
  url = "http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{api_key}"

  response = Net::HTTP.get(URI.parse(url))
  weather_data = JSON.parse(response)

  weather = weather_data['weather'][0]
    puts "Weather in #{city_name}: #{weather['main']} - #{weather['description']}"
end

# APIキーと都市名を設定してください
api_key = "bbc2ca3e507e61ba0312afa078ee603a"
city_name = ARGV[0]



loop do
  # 現在の時刻を取得
  current_time = Time.now
  puts "-----"
  puts "Current Time: #{current_time}"
  
  # 天気情報を取得
  get_weather(city_name, api_key)
  
  # 10分待機
  sleep(600)
end