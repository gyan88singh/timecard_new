Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
 # get "log_out" => "sessions#destroy", :as => "log_out"
  #get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "logins#destroy", :as => "log_out"
  
  get "my_account" => "users#my_account"
    
  get "chnage_password" => "users#change_password"
  
  resources :users do
     get "delete"
     get "search_user_list"
     get "edit_department"
     post "update_department"
    collection { get :new_export }
   end
   
  resources :logins do
    get "login"
       
  end
 
  resources :sessions do
          get '/login' => 'sessions#new'
          post '/login' => 'sessions#create'
          get "index"
         
          post "new"
         
    end
     
  
   
  resources :users do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end
     
  resources :employees do
    get "import_index"
      collection { post :import }
     end
   
   resources :time_sheets do
    
       collection { post :import }
   end  
      
  #resources :time_reports do
     
     get "time_home" => 'time_reports#time_home'
  # end  
  
  resources :departments_users do
      
     
     collection { get :edit }
    end  
   
 
      
 # root :to => "users#index"
 root :to => "sessions#new"
 # root :to => "logins#new"
  #resources :users
 # resources :sessions
      
      
end
