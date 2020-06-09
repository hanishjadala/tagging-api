Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'api/v1/sessions',
               registrations: 'api/v1/registrations'
             }
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
		  resources :users do 
		    member do
		    	patch :disable_user
		    	patch :add_tag
		    	patch :remove_tag
		    end
		    collection do 
		    	get :sort_field
		    end
		  end

		  resources :tags do
		    collection do 
		    	get :sort_field
		    end		  	
		  end
    end
  end              
end
