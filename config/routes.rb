Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  get '/users/login', to: 'authentication#login'
  get '/users/authenticate', to: 'authentication#authenticate'
  get '/token', to: 'pay_pal#token'
  # Defines the root path route ("/")
  # root "articles#index"
end
