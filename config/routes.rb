Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :entities, only: [:new, :show, :create]

  namespace :api do
    resources :entities, only: [:index, :create]
  end

	root to: 'entities#new'
	get '*short_url', to: 'entities#redirect'
end
