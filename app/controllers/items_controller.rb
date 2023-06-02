require 'base64'
require 'json'
require 'net/http'
API_KEY = ENV['GOOGLE_CLOUD_KEY']
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"


class ItemsController < ApplicationController
  def index
    @items = Item.where(user_id: current_user.id)
  end

  def show
  @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.genre_id = 4

    if @item.save!
      analyze_image(@item)
      redirect_to item_path(@item), notice: "アイテムが作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])

    if @item.user != current_user
      redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end

  def update
    @item = Item.find(params[:id])
    if  @item.update(item_params)
      analyze_image(@item)
      redirect_to item_path(@item), notice: "更新に成功しました。"
   else
    render :edit
   end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :clean_index)
  end

  def analyze_image(item)
    image_data = item.image.blob.download
    base64_image = Base64.strict_encode64(image_data)

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
    request.body = body

    response = https.request(request)
    response_rb = JSON.parse(response.body)

    if response_rb['responses'][0]['imagePropertiesAnnotation']
      colors = response_rb['responses'][0]['imagePropertiesAnnotation']['dominantColors']['colors']

      rgb_values = colors.map do |color|
        red = color['color']['red']
        green = color['color']['green']
        blue = color['color']['blue']

        (red * 10000 + green * 100 + blue).to_s
      end

      color_differences = colors.map do |color|
        red = color['color']['red']
        green = color['color']['green']
        blue = color['color']['blue']

        difference = [red, green, blue].max - [red, green, blue].min
        difference.to_s
      end

      item.color_difference = color_differences.join('')
      item.rgb = rgb_values.join('')
      item.save
    else
      puts '色情報がありません'
    end
  end
end

