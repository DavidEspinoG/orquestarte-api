Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  get '/users/login', to: 'authentication#login'
  post '/users/create', to: 'users#create'
  get '/users', to: 'users#index'
  delete '/users/:id/delete', to: 'users#destroy'
  post '/users/:id/update_password', to: 'users#update_password'
  get '/students', to: 'students#index'
  get '/students_from_user', to: 'students#students_from_user'
  delete '/students/:student_id', to: 'students#destroy'
  get '/schools', to: 'schools#index'
  get '/token', to: 'pay_pal#token'
  # Defines the root path route ("/")
  # root "articles#index"
end
