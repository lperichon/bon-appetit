require 'test_helper'
require 'blueprints'

class SignupsControllerTest < ActionController::TestCase
  context "get new" do
    setup { get :new }
    should_respond_with :success
  end

  context "post create" do
    setup do
      post :create, :user => { :username => "test", :email => "test@test.com" }
    end

    should_redirect_to("the login page") { login_path }
  end
end