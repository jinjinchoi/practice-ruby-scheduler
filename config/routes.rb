Rails.application.routes.draw do
  root 'home#index'
  get '/index/:lecture_type' => "home#index"
  get '/home/index' => 'home#index'
  get 'mockInitialize' => "home#mock"
  get 'initialize' => "home#init"

  get '/tutor/new' => "tutor#new"
  post '/tutor/create' => "tutor#create"

  get '/schedule/update' => "home#update"
  get '/schedule/new' => "schedule#new"
  post '/schedule' => "schedule#addSchedule"
  patch '/schedule' => "home#updateSchedule"
  delete 'schedule/:schedule_id/delete' => 'home#deleteSchedule', as: 'schedule_delete'
  get '/schedule/:schedule_id/delete' => 'home#deleteSchedule'
end
