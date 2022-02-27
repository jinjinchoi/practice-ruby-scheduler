Rails.application.routes.draw do
  root 'home#index'
  get '/index/:lecture_type' => "home#index"
  get '/home/index' => 'home#index'
  get 'mockInitialize' => "home#mock"
  get 'initialize' => "home#init"
end
