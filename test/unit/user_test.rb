require 'test_helper'
require 'blueprints'

class UserTest < ActiveSupport::TestCase
  context "any user" do
    setup { @user = User.make }

    subject { @user }

    should_have_and_belong_to_many :restaurants
    should_have_many :managed_restaurants
    
    should_validate_presence_of :email
    should_validate_presence_of :username
  end
  
  context "activating a user" do
    setup do
      @user = User.make(:active => false)
      @user.activate!({:user => {:password => 'pass', :password_confirmation => 'pass'}})
    end

    should "make the user active" do
      assert @user.active?
    end
  end
end