
require 'base64'
require 'json'
require 'net/http'

IMAGE_FILE = ARGV[0]
API_KEY = ENV['GOOGLE_CLOUD_KEY']
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"

base64_image = Base64.strict_encode64(File.new(IMAGE_FILE, 'rb').read)

body = {
  requests: [{
    image: {
      content: base64_image
    },
    features: [
      {
        type: 'IMAGE_PROPERTIES',
        maxResults: 1
      }
    ]
  }]
}.to_json

uri = URI.parse(API_URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/json"
response = https.request(request, body)

response_rb = JSON.parse(response.body)

#色の差分を計算するメソッド
def colordifference(red,green,blue) 
  value1 = red
value2 = green
value3 = blue

# 最大値と最小値を見つける
min_value = [value1, value2, value3].min
max_value = [value1, value2, value3].max

# 最小値と最大値の差を変数に格納
difference = max_value - min_value

# 変数を出力
puts "差: #{difference}"
end



# データの必要なもののみ抽出
if response_rb['responses'][0]['imagePropertiesAnnotation']
  colors = response_rb['responses'][0]['imagePropertiesAnnotation']['dominantColors']['colors']
  colors.each do |color|
    puts "Color: #{color['color']['red']}, #{color['color']['green']}, #{color['color']['blue']}"

    # 色の差分を計算
    colordifference(color['color']['red'],color['color']['green'],color['color']['blue'])

  end
else
  puts '色情報がありません'
end


