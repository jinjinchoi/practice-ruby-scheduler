Rails.application.routes.draw do
  root 'home#index'
  get '/index/:lecture_type' => "home#index"
  get '/home/index' => 'home#index'
  get 'mockInitialize' => "home#mock"
  get 'initialize' => "home#init"
  get 'update' => "home#update"

  get '/tutor/new' => "tutor#new"
  post '/tutor/create' => "tutor#create"

  patch '/schedule' => "home#updateSchedule"
  get '/delete/:schedule_id' => "home#deleteSchedule"
end
