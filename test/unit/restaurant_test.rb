require 'test_helper'
require 'blueprints'

class RestaurantTest < ActiveSupport::TestCase
  context "any restaurant" do
    setup { @restaurant = Restaurant.new }

    subject { @restaurant }

    should_belong_to :manager
    should_have_many :orders
    should_have_many :products
    should_have_many :product_types
    should_have_and_belong_to_many :users
    should_have_many :contacts

    should_validate_presence_of(:name)
  end
end
