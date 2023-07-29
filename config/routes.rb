Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#index'
  get '/fox', to: 'health#fox'
  # Defines the root path route ("/")
  # root "articles#index"
end
