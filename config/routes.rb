Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  post '/users/login', to: 'authentication#login'
  post '/users/signup', to: 'users#create'
  get '/users', to: 'users#index'
  delete '/users/:id/delete', to: 'users#destroy'
  post '/users/:id/update_password', to: 'users#update_password'
  get '/students', to: 'students#index'
  post '/students', to: 'students#create'
  get '/students_from_user', to: 'students#students_from_user'
  delete '/students/:student_id', to: 'students#destroy'
  get '/schools', to: 'schools#index'
  get '/token', to: 'pay_pal#token'
  post '/paypal/create-paypal-order', to: 'pay_pal#create_order'
  post '/paypal/capture-payment', to: 'pay_pal#capture_payment'
  # Defines the root path route ("/")
  # root "articles#index"
end
