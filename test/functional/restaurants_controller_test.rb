require 'test_helper'
require 'blueprints'

class RestaurantsControllerTest < ActionController::TestCase
  context 'when user is not logged in' do
    setup { get :show }
    should_redirect_to("the login page") { login_url }
    should_set_the_flash_to 'You must be logged in to access this page'
  end

  context 'logged in as a normal user' do
    setup { login }

    context "get show" do
      setup { get :show }
      should_respond_with :success
    end

    context "update restaurant" do
      setup do
        put :update, :restaurant => {:name => 'New Name'}
      end

      should 'change the name' do
        assert_equal 'New Name', assigns(:restaurant).name
      end
    end
  end
end
