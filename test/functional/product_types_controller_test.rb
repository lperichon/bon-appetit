require 'test_helper'
require 'blueprints'

class ProductTypesControllerTest < ActionController::TestCase
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
      should_assign_to :product_types
    end

    context "get new" do
      setup { get :new }
      should_respond_with :success
    end

    context "create product type" do
      setup { post :create, :product_type => ProductType.plan }

      should_assign_to :product_type
      should_redirect_to("product type's show page") { product_type_path(assigns(:product_type)) }
    end

    context "show product type" do
      setup { get :show, :id => ProductType.make(:restaurant => @current_restaurant).id }

      should_respond_with :success
    end

    context "get edit" do
      setup { get :edit, :id => ProductType.make(:restaurant => @current_restaurant).id }
      should_respond_with :success
    end

    context "update product type" do
      setup do
        product_type = ProductType.make(:restaurant => @current_restaurant)
        put :update, :id => product_type.id, :product_type => {:name => 'Bob'}
      end

      should_assign_to :product_type
      should_redirect_to("product type's show page") { product_type_path(assigns(:product_type)) }
    end

    context "destroy product type" do
      setup do
        product_type = ProductType.make(:restaurant => @current_restaurant)
        delete :destroy, :id => product_type.id
      end

      should_redirect_to("product type list") { product_types_path }
    end
  end
end
