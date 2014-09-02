Myapp::Application.routes.draw do

  get "sessions/new"

  get "users/new"

  get "users/create"

  get "users/edit"

  get "users/update"

  get "abc/doit"

  get "termlinks/create"
  
  match '/blog' => 'pages#blog'
  match '/info' => 'pages#info'
  match '/kontakt' => 'pages#kontakt'
  
  get 'rex/:inp', to: 'terms#index'
  post 'rex', to: 'terms#index'
  get 'rex', to: 'terms#index'
  resources :terms do
    collection do
      get "index"
      post "index"
      get "show"
      get "new"
      get "create"
      get "store"
      post "store"
    end
  end
  
  
   
  resources :termlinks do
    collection do
      get "destroy"
    end
  end
  
  root :to => "terms#index"
  #resources :user_sessions do
  #  root :to => "user_sessions#new"
  #end
  
  match 'login', :to => 'sessions#new', :as => 'login'
  match 'logout', :to => 'sessions#destroy', :as => 'logout'
  match 'signup' => "users#new", :as => "signup"
  resources :users
  resources :sessions
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
