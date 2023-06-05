require 'net/http'
require 'json'

def get_weather(city_name, api_key)
  url = "http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{api_key}"

  response = Net::HTTP.get(URI.parse(url))
  weather_data = JSON.parse(response)

  main = weather_data['main']
  weather = weather_data['weather'][0]

  temperature_celsius = main['temp'] - 273.15
  feels_like_celsius = main['feels_like'] - 273.15

  puts "気温 in #{city_name}: #{temperature_celsius.round(2)}°C"
  puts "体感温度 in #{city_name}: #{feels_like_celsius.round(2)}°C"
  puts "天気 in #{city_name}: #{weather['main']}"
  puts "-----"
end

# APIキーと都市名を設定してください
api_key = "bbc2ca3e507e61ba0312afa078ee603a"
city_name = ARGV[0]

get_weather(city_name, api_key)
