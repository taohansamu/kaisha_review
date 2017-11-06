Rails.application.routes.draw do
  put 'users/update_profile'


  put '/update_password' => 'devise/registrations#update_password'

  get 'home/index'
  # get 'home/view'
  # get 'home/reviews'
  get 'companies/:company_id/reviews/current_review' => 'reviews#get_current_review'
  resources :skills
  resources :types
  resources :companies do
    resources :reviews
  end

  devise_for :users, controllers:{omniauth_callbacks: "users/omniauth_callbacks"}
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
