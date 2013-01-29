NardDog::Application.routes.draw do

	devise_for :users

	resources :users

	resources :apps

	resources :cloudfile_containers

	resources :sftp_storages

	root :to => "home#index"
end
