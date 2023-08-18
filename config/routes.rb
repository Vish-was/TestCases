Rails.application.routes.draw do
  resources :programs
  resources :enrollments
  resources :users do 
    resources :teachers 
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
