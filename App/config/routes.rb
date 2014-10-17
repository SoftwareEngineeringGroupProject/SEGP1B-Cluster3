Rails.application.routes.draw do

  resources :muas

  resources :submissions


  root  to: 'application#index', :as => :root

  get 'submit' => "submissions#new"

     ###############################################
     # Past Project Routes
     ###############################################
     get 'projects/info' => 'projects#info', as: 'info'
     get 'projects' => 'projects#index', as: 'index'
     get 'projects/new' => 'projects#new', as: 'new'
     post 'projects/new' => 'projects#create'
     # post '/student_projects' => 'projects#create'
     # match 'projects/new' => 'projects#create', via: [:get, :post]
     match '/student_projects' => 'projects#create', via: [:get, :post]
     get 'projects/contact' => 'projects#contact', as: 'contact'
     get 'projects/:id/show' => 'projects#show', as: 'project'
     get 'projects/:id/edit' => 'projects#edit', as: 'edit'
     post 'projects/:id/update' => 'projects#update', as: 'update'
     get 'projects/:id/unchanged' => 'projects#unchanged', as: 'unchanged'
     get 'projects/:id/destroy' => 'projects#destroy', as: 'destroy'
     patch 'projects/:id/destroy' => 'projects#delete', as: 'delete'
     get 'projects/search' => 'projects#search', as: 'search'
      get 'projects/notfound' => 'projects#notfound', as: 'notfound'

     ###############################################
     # Past Project Students Routes
     ###############################################
     get 'students/delete/:id' => 'students#delete', as: 'student_delete'
     get 'students/edit/:id' => 'students#edit', as: 'student_edit'
     patch 'students/update/:id' => 'students#update', as: 'student_update'
     get 'students/search' => 'students#search', as: 'student_search'
 
     get 'projects/:id/students/new' => 'students#new', as: 'student_new'
     post 'projects/:id/addstudent' => 'students#create', as: 'student_create'
     get 'projects/:id/addstudent' => 'projects#addstudent', as: 'student_created_to_project'
     post 'projects/:id/addstudent' => 'projects#addstudent_create'
       get 'students/notfound' => 'students#notfound', as: 'student_notfound'



  # Dashboards
  get 'dashboards/view/:state' => "dashboards#view"
  get 'dashboards/view/' => "dashboards#view", :as => :admin_dashboard
  post 'dashboards/view/:state' => 'dashboards#action_handler', :as => :action_handler
  post 'dashboards/view' => 'dashboards#action_handler'
  get 'dashboards/edit_desc' => "dashboards#edit_desc", :as => :edit_desc
  post 'dashboards/edit_desc' =>"dashboards#action_handler"

  get 'dashboards/assign_students' => "dashboards#assign_students", :as => :assign_students
  post 'dashboards/assgin_students' => "dashboards#action_handler"

  #get 'profile' => "application#profile", :as => :profile_path
  #post 'login/:username/:password' => 'application#login'

#Users/Login
  #User Management
  get 'users/list' => "users#index", :as => :list_all_path
  get 'users/show/:id' => "users#show", :as => :show_user_path
  get 'users/edit/:id' => "users#edit", :as => :edit_user_path
  get 'users/removeuser/:id' => "users#destroy", :as => :delete_user_path
  patch 'users/update/:id' => "users#update", :as => :update_user_path

  #registration
  get 'signup/' => "users#new", :as => :signup
  post 'signup/' => "users#create", :as => :create_user_path
  get 'admin/signup/' => "users#newadmin", :as => :admin_signup_path
  post 'admin/signup/' => "users#createadmin", :as => :create_admin

  #Login/Logout
  get 'login' => 'sessions#login', :as => :login
  get 'logout' => 'sessions#logout', :as => :logout
  post 'login' => 'sessions#login_attempt'

  #Authorization
  get 'unauthorized/' => "sessions#unauthorized", :as => :unauthorized


  #User Profile
  get 'profile' => "users#profile", :as => :profile
  get 'profile/edit' => "users#editprofile", :as => :edit_profile
  post 'profile/edit' => "users#submitprofileedits", :as => :edit_profile_submit

  # Password Reset/Change
  get 'profile/changepw' => "users#changepw", :as => :change_pw
  post 'profile/changepw' => "users#performreset", :as => :perform_reset
  get 'forgottenpassword' => "users#forgot_password", :as => :forgot_password
  post 'forgottenpassword' => "users#email_new_password", :as => :email_new_password


  # Industry actions
  get 'industry/showList' => "industry#showList", :as => :industry_dashboard
  get 'industry/showList/:id' => "industry#showList", :as => :show_all_industry_project

  get 'industry/edit' => "industry#edit"
  get 'industry/edit/:id' => "industry#edit", :as => :edit_industry_project

  get 'industry/update/' => "industry#update"

  post 'industry/update/' => "industry#showList"

  patch 'industry/update' => "industry#update", :as => :update_industry_project

  post 'industry/showList' => "industry#action_to_project"
  post 'industry/showList/:id' => "industry#action_to_project", :as => :action_to_industry_project


  post 'industry/remove/:id' => "industry#remove", :as => :remove_industry_project
  get 'industry/delete' => "industry#delete", :as => :delete_industry_project
  post 'industry/delete' => "industry#pending", :as => :delete_pending_project


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
