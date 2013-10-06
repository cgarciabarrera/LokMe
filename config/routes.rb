LokMe::Application.routes.draw do
  resources :points do

    collection do
      get :manual
      post :manual
    end
  end
  resources :devices do
    collection do
      get :assign
      post :assign
      post :verify
    end

  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end