require 'test_helper'
require 'blueprints'

class UsersControllerTest < ActionController::TestCase
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
      should_assign_to :users
    end

    context "get new" do
      setup { get :new }
      should_respond_with :success
    end

    context "create user" do
      setup { post :create, :user => User.plan }

      should_assign_to :user

      should_redirect_to("user's show page") { user_path(assigns(:user)) }

      should('send an activation email') do
        assert_sent_email do |email|
          email.subject =~ /Activation Instructions/ &&
          email.to.include?(assigns(:user).email) &&
          email.body.include?("An account on #{@current_restaurant.name} has been created for you!")
        end
      end
    end

    context "show user" do
      setup do
        user = User.make
        @current_restaurant.users << user
        @current_restaurant.save
        get :show, :id => user.id
      end

      should_respond_with :success
    end

    context "update user" do
      setup do
        user = User.make
        @current_restaurant.users << user
        @current_restaurant.save
        put :update, :id => user.id, :user => {:username => 'Bob'}
      end

      should_assign_to :user
      should_redirect_to("user's show page") { user_path(assigns(:user)) }
    end

    context "destroy user" do
      setup do
        user = User.make
        @current_restaurant.users << user
        @current_restaurant.save
        delete :destroy, :id => user.id
      end

      should_redirect_to("user list") { users_path }
    end
  end
end
