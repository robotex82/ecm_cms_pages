Dummy::Application.routes.draw do
  get "admin/index"

  devise_for :admins, :skip => :registrations
  
  # Prefix route urls with "admin" and route names with "rails_admin_"
  scope "admin", :module => :rails_admin, :as => "rails_admin" do
    scope "history", :as => "history" do
      controller "history" do
        match "/list", :to => :list, :as => "list"
        match "/slider", :to => :slider, :as => "slider"
        match "/:model_name", :to => :for_model, :as => "model"
        match "/:model_name/:id", :to => :for_object, :as => "object"
      end
    end

    # Routes for rails_admin controller
    controller "main" do
      match "/", :to => :index, :as => "dashboard"
      get "/:model_name", :to => :list, :as => "list"
      post "/:model_name/list", :to => :list, :as => "list_post"
      match "/:model_name/export", :to => :export, :as => "export"
      get "/:model_name/new", :to => :new, :as => "new"
      match "/:model_name/get_pages", :to => :get_pages, :as => "get_pages"
      post "/:model_name", :to => :create, :as => "create"

      get "/:model_name/:id", :to => :show, :as => "show"
      get "/:model_name/:id/edit", :to => :edit, :as => "edit"
      put "/:model_name/:id", :to => :update, :as => "update"
      get "/:model_name/:id/delete", :to => :delete, :as => "delete"
      delete "/:model_name/:id", :to => :destroy, :as => "destroy"

      post "/:model_name/bulk_action", :to => :bulk_action, :as => "bulk_action"
      post "/:model_name/bulk_destroy", :to => :bulk_destroy, :as => "bulk_destroy"
    end
  end

  match 'home' => 'home#index', :as => :home
  get "/*page", :to => "page#respond", :as => :template
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
