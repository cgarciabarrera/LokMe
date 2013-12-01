LokMe::Application.routes.draw do
  resources :shareds



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
      get :stopsharing
      post :share
      post :cuantos
      post :listamisdevices
      post :adddeviceapi
      post :puntosdedevice
      get :puntosdedevice
      get :listamisdevicesconcompartidos
      post :listamisdevicesconcompartidos

    end

  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy]
      resources :registermobile, :only => [:create]
    end
  end

end