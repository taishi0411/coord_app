
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


# データの必要なもののみ抽出

puts response_rb 
