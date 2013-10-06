LokMe::Application.routes.draw do
  resources :points

  resources :devices

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end