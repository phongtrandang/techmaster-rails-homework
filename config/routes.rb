Rails.application.routes.draw do
  get '/users/api/data', to: 'users#data'
  get '/users', to: 'users#index'
end
