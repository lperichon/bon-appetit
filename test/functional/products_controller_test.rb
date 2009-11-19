require 'test_helper'
require 'blueprints'

class ProductsControllerTest < ActionController::TestCase
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
      should_assign_to :products
    end

    context "get new" do
      setup { get :new }
      should_respond_with :success
    end

    context "create product type" do
      setup { post :create, :product => Product.plan }

      should_assign_to :product
      should_redirect_to("product type's show page") { product_path(assigns(:product)) }
    end

    context "show product type" do
      setup { get :show, :id => Product.make(:restaurant => @current_restaurant).id }

      should_respond_with :success
    end

    context "get edit" do
      setup { get :edit, :id => Product.make(:restaurant => @current_restaurant).id }
      should_respond_with :success
    end

    context "update product type" do
      setup do
        product = Product.make(:restaurant => @current_restaurant)
        put :update, :id => product.id, :product => {:name => 'Bob'}
      end

      should_assign_to :product
      should_redirect_to("product type's show page") { product_path(assigns(:product)) }
    end

    context "destroy product" do
      setup do
        product = Product.make(:restaurant => @current_restaurant)
        delete :destroy, :id => product.id
      end

      should_redirect_to("product list") { products_path }
    end
  end
end
