Rails.application.routes.draw do
  resources :users, :tasks

  root 'pages#index'

  get '/login' => 'pages#new'
  post '/login' => 'pages#create'
  delete '/logout' => 'pages#destroy'

  get '/charities' => 'pages#charities'


  get '/signup/:id' => 'users#new'
  post '/signup' => 'users#create'

  put '/convert-guest/:id' => 'users#convert_guest_to_user'

  get '/users/:id/add-credit-card' => 'users#add_credit_card'
  post '/users/:id/save-credit-card' => 'users#save_credit_card'
  get '/users/:id/save-credit-card' => 'users#add_credit_card'

  get '/account' => 'users#show'
  get '/account/charities' => 'users#charities'
  put '/set_charity/:id' => 'users#set_default_charity', as: :charity


  get '/users/:id/confirm-task' => 'tasks#confirm_task'
  post '/tasks/:id/complete' => 'tasks#completed'


end
