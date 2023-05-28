Rails.application.routes.draw do
  get '/' => 'home#top'
  get '/users/index' => 'home#index'

  devise_for :users
  
  resources :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'  #deviseのログアウトを解消
  end

end
