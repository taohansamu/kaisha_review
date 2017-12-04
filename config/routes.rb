Rails.application.routes.draw do
  put 'users/update_profile'

  delete 'destroy_relationship_by_company/:company_id' => 'relationships#destroy_by_company'
  put '/update_password' => 'devise/registrations#update_password'

  get 'home/index'
  # get 'home/view'
  # get 'home/reviews'
  get 'companies/:company_id/reviews/current_review' => 'reviews#get_current_review'
  devise_for :users, controllers:{omniauth_callbacks: "users/omniauth_callbacks", sessions: 'users/sessions'}
  Rails.application.routes.draw do
    notify_to :users, controller: 'users/notifications'
    mount ActionCable.server => '/cable'
  end

  resources :skills
  resources :types
  resources :companies do
    resources :reviews
  end
  resources :users do
    member do
      get :following
    end
  end
  resources :companies do
    member do
      get :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
