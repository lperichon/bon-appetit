ActionController::Routing::Routes.draw do |map|
  Translate::Routes.translation_ui(map) if RAILS_ENV != "production"
  
  map.namespace :admin do |admin|
    admin.root :controller => :restaurants
    admin.resources :restaurants do |restaurant|
      restaurant.resources :users
      restaurant.resources :product_types
      restaurant.resources :products
      restaurant.resources :orders do |order|
        order.resources :order_items
      end
      restaurant.resources :users
      restaurant.resources :contacts
    end
    admin.resources :countries do |country|
      country.resources :divisions do |division|
        division.resources :cities
      end
    end
    admin.resources :table_types
    admin.resources :email_types
    admin.resources :phone_types
    admin.resources :address_types
    admin.resources :instant_messenger_types
    admin.resources :instant_messenger_protocols
    admin.resources :website_types
    admin.resources :identification_types
    admin.resources :user_sessions
  end
  
  map.resources :users  do |users|
    users.contactable_resources
  end

  map.resources :tables
  map.resources :product_types
  map.resources :products, :collection => {:autocomplete => :get}
  map.resources :contacts, :collection => {:autocomplete => :get} do |contact|
    contact.contactable_resources
  end
  map.resources :orders, :has_many => :order_items
  map.resource :dashboard
  map.resource :profile
  map.resource :restaurant
  map.resource :subscription, :member=>{:history=>:get, :credit_card=>:get, :cancel=>:get, :store_credit_card=>:post}
  map.setup_wizard 'setup', :controller => 'setup'

  map.resources :signups
  map.resources :user_sessions
  map.resources :password_resets

  map.admin_login 'admin/login', :controller => 'admin/user_sessions', :action => 'new'
  map.admin_logout 'admin/logout', :controller => 'admin/user_sessions', :action => 'destroy'
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'  
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.signup 'signup', :controller => 'signups', :action => 'new'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => 'high_voltage/pages', :action => 'show', :id => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
