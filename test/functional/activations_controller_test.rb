require 'test_helper'
require 'blueprints'

class ActivationsControllerTest < ActionController::TestCase
  context "as an inactive user" do
    setup { @user = User.make(:active => false); }

    context "get new" do
      setup { get :new, :activation_code => @user.perishable_token }
      should_respond_with :success
      should_assign_to :user
    end

    context "post create" do
      setup { post :create, :id => @user.id, :user => {:password => 'pass', :password_confirmation => 'pass'} }
      should_assign_to :user
      should_redirect_to("the dashboard") { dashboard_path }
    end
  end
end