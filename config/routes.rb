Rails.application.routes.draw do
  root 'home#index'

  # get "home/data" => "home#data"
  get "home/data", to: "home#data", as: :data
  # get "home/db_action" => "home#db_action"
  # get "home/db_action", to: "home#db_action", as: :db_action
  post "home/db_action", to: "home#db_action", as: :db_action


  get '/home/index' => 'home#index'
  get 'mockInitialize' => "home#mock"
end
