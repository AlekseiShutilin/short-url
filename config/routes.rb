Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :entities, only: [:new, :show, :create]
	root to: 'entities#new'
end
