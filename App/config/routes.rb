Rails.application.routes.draw do
  resources :submissions
  
  root  to: 'application#index'

  get 'submit' => "submissions#new"
  get 'dashboards/view/:state' => "dashboards#view"
  get 'dashboards/view/' => "dashboards#view"
  post 'dashboards/view/:state' => 'dashboards#change_state', :as => :change_state
  post 'dashboards/view/' => 'dashboards#change_state'  


  get 'login' => "application#login"
  get 'profile' => "application#profile", :as => :profile_path
  post 'login/:username/:password' => 'application#login'
  
  #Users/Login
  get 'users/list' => "users#index", :as => :list_all_path
  get 'users/show/:id' => "users#show", :as => :show_user_path
  get 'users/edit/:id' => "users#edit", :as => :edit_user_path
  get 'users/removeuser/:id' => "users#destroy", :as => :delete_user_path
  get 'users/signup/' => "users#new", :as => :signup_path
  post 'users/update/:id' => "users#update", :as => :update_user_path
  post 'users/signup/' => "users#create", :as => :create_user_path


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
end
