require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_header
  before_action :authenticate_user!, except: [:top, :index]

  def set_header
    if user_signed_in?
    current_user_id = current_user.id
    @user = User.find(current_user_id)

    api_key = "bbc2ca3e507e61ba0312afa078ee603a"

    get_weather(@user.home_adress, api_key)
    else
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :home_adress])
  end

  def after_sign_in_path_for(resource) 
    users_index_path
  end

  def get_weather(city_name, api_key)
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{api_key}"
  
    response = Net::HTTP.get(URI.parse(url))
    weather_data = JSON.parse(response)
  
    main = weather_data['main']
    weather = weather_data['weather'][0]
  
    temperature_celsius = main['temp'] - 273.15
    feels_like_celsius = main['feels_like'] - 273.15
  
    @temperature_celsius = temperature_celsius.round(2)
    @main = weather['main']
  end



  
end
