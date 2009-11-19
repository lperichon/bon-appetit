require 'test_helper'
require 'blueprints'

class UserSessionsControllerTest < ActionController::TestCase
  context "get new" do
    setup { get :new }
    should_respond_with :success
  end
  context "as a registered user" do
    setup { @user = User.make; UserSession.find.destroy }

    context "create user session" do
      setup do
        post :create, :user_session => { :username => @user.username, :password => "test" }
        assert @user_session = UserSession.find
      end

      should("login as user") { assert_equal @user, @user_session.user }
      should_redirect_to("the dashboard") { dashboard_path }
      end

    context "logged in" do
      setup { login(@user) }

      context "destroy user session" do
        setup { delete :destroy }

        should("destroy the session") { assert_nil UserSession.find }
        should_redirect_to('the login page') { root_path }
      end
    end
  end
end