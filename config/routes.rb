Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/authorize', to: 'authorize_lichess#index'

  get '/authorize/token', to: 'authorize_lichess#token'

  get '/dashboard', to: 'dashboard#index'

  get '/dashboard/review', to: 'dashboard#review'

  get '/about', to: 'about#index'

  get '/about/detail', to: 'about#detail'

  root to: redirect('/about', status: 302)
end