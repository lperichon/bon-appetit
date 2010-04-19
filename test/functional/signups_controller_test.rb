require 'test_helper'
require 'blueprints'

class SignupsControllerTest < ActionController::TestCase
  context "post create" do
    setup do
      post :create, :user => { :username => "test", :email => "test@test.com" }
    end

    should_redirect_to("the root page") { root_path }

    should('send an activation email') do
      assert_sent_email do |email|
        email.subject =~ /Activation Instructions/ &&
        email.to.include?('test@test.com') &&
        email.body.include?('Thank you for creating an account!')
      end
    end
  end
end