require 'test_helper'
require 'blueprints'

class ProductTest < ActiveSupport::TestCase
  context "any product" do
    setup { @product = Product.make }

    subject { @product }

    should_belong_to :restaurant
    should_validate_presence_of :restaurant

    should_belong_to :product_type
    should_validate_presence_of :product_type

    should_validate_presence_of :name

    should_validate_presence_of :price
    should_allow_values_for(:price, 0.01, 1, 100)
    should_not_allow_values_for(:price, 0, -1, 'a')

    #should_validate_uniqueness_of :code, :scoped_to => :restaurant, :allow_nil => true
  end
end