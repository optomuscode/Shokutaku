Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  # Add a custom GET route for logout as a fallback
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
