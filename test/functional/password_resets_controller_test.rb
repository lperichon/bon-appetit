require 'test_helper'
require 'blueprints'

class PasswordResetsControllerTest < ActionController::TestCase
  context "as an active user" do
    setup { @user = User.make; UserSession.find.destroy; @user.reload}

    context "post create" do
      setup { post :create, :email => @user.email }

      should_redirect_to("the login page") { login_path }
    end

    context "put update" do
      setup { put :update, :id => @user.perishable_token, :user => { :password => 'pass', :password_confirmation => 'pass' } }

      should_redirect_to("the dashboard") { dashboard_path }
    end

    context "get edit" do
      setup { get :edit, :id => @user.perishable_token }

      should_respond_with :success
    end
  end
end