require 'test_helper'
require 'blueprints'

class OrdersControllerTest < ActionController::TestCase
  context 'when user is not logged in' do
    setup { get :index }
    should_redirect_to("the login page") { login_url }
    should_set_the_flash_to 'You must be logged in to access this page'
  end

  context 'logged in as a normal user' do
    setup { login }

    context "get index" do
      setup { get :index }
      should_respond_with :success
      should_assign_to :orders
    end
  end
end