Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :entities, only: [:create, :index]
  end
  resources :entities, only: [:new, :show, :create]


	root to: 'entities#new'
	get '*short_url', to: 'entities#redirect'
end
