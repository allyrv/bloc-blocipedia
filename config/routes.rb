Rails.application.routes.draw do

	get 'charges/new'
	get 'charges/create'

	resources :wikis
  	
  	devise_for :users

  	resources :charges, only: [:new, :create, :destroy]

  	get 'about' => 'welcome#about'

  	get 'downgrade' => 'users#downgrade'

  	root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end