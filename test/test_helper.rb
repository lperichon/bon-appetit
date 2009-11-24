ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require "authlogic/test_case" # include at the top of test_helper.rb

class ActiveSupport::TestCase

  # Add more helper methods to be used by all tests here...
  def make_order_with_items(restaurant = make_restaurant)
    order = Order.make(:restaurant => restaurant)
    (rand(10) + 1).times { make_order_item(order, restaurant) }
    order
  end

  def make_order_item(order = nil, restaurant = make_restaurant)
    product = Product.make(:restaurant => restaurant, :product_type => ProductType.make(:restaurant => restaurant)) 
    order ||= Order.make(:restaurant => restaurant)
    order_item = order.order_items.make(:product => product)
    order_item
  end

  def make_contact(restaurant = make_restaurant)
    Contact.make(:restaurant => restaurant)
  end

  def make_restaurant
    user = User.make
    restaurant = Restaurant.make(:manager => user)
    restaurant.users << user
    restaurant.save
    restaurant
  end
end

class ActionController::TestCase
  setup :activate_authlogic # run before tests are executed
  
  def login(user = nil)
    unless user
      restaurant = make_restaurant
      user = restaurant.manager
    end
    assert UserSession.create(user)
    @current_user = user
    @current_restaurant = @current_user.restaurants.first
    user
  end
end
