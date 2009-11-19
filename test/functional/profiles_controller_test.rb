require 'test_helper'
require 'blueprints'

class ProfilesControllerTest < ActionController::TestCase
  context 'when user is not logged in' do
    setup { get :edit }
    should_redirect_to("the login page") { login_url }
    should_set_the_flash_to 'You must be logged in to access this page'
  end

  context 'logged in as a normal user' do
    setup { login }

    context "get edit" do
      setup { get :edit }
      should_respond_with :success
    end

    context "update product type" do
      setup do
        put :update, :user => {:first_name => 'Bob'}
      end

      should_redirect_to("the dashboard") { dashboard_path }
    end
  end
end
