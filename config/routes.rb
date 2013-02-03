NardDog::Application.routes.draw do

	devise_for :users

	resources :users

	resources :apps
	get "/apps/:id/verify" => "apps#verify", as: 'verify_app'
	get "/apps/:id/get_version" => "apps#get_version", as: 'get_app_version'

	resources :cloudfile_containers

	resources :sftp_storages

	resources :backups
	get "/backups/:id/run_backup" => "backups#run_backup", as: 'run_backup'

	root :to => "home#index"
end
