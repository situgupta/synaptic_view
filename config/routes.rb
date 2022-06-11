Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers:{
    registrations: 'users/registrations',
    sessions:'users/sessions',
    omniauth_callbacks:'users/omniauth_callbacks'
  }

 

  resources :csv_records do
    collection {post :import}
    
  end
  # resources :csv_records, only: [:time_series]

  namespace :csv_records do
    post 'time_series'
  end

  





  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
