ActionController::Routing::Routes.draw do |map|
  map.resources :tests

  map.resources :tests

  map.resources :tests

  map.resources :stores,
                :customers,
                :suppliers,
                :invoices,
                :purchase_bills,
                :sale_bills,
                :bills,
                :purchase_requests,
                :audited_stock_records,
                :users,
                :user_sessions

  map.resources :products, :collection => { :autocomplete => :get }
  map.resources :product_batches, :collection => { :autocomplete => :get }


  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.home 'home', :controller => "home"

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "public"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
