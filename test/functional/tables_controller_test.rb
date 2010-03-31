require 'test_helper'
require 'blueprints'

class TablesControllerTest < ActionController::TestCase
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
      should_assign_to :tables
    end

    context "get new" do
      setup { get :new }
      should_respond_with :success
    end

    context "create table" do
      setup { post :create, :table => Table.plan }

      should_assign_to :table
      should_redirect_to("table's show page") { table_path(assigns(:table)) }
    end

    context "show table" do
      setup { get :show, :id => Table.make(:restaurant => @current_restaurant).id }

      should_respond_with :success
    end

    context "update table" do
      setup do
        table = Table.make(:restaurant => @current_restaurant)
        put :update, :id => table.id, :table => {:max_party => 3}
      end

      should_assign_to :table
      should_redirect_to("table's show page") { table_path(assigns(:table)) }
    end

    context "update multiple tables" do
      setup do
        table1 = Table.make(:restaurant => @current_restaurant)
        table2 = Table.make(:restaurant => @current_restaurant)

        put :update, :tables_attributes => {table1.id => {:top => 30, :left => 200}, table2.id => {:top => 30, :left => 200}}
      end

      should_redirect_to("table list") { tables_path }
    end

    context "destroy table" do
      setup do
        table = Table.make(:restaurant => @current_restaurant)
        delete :destroy, :id => table.id
      end

      should_redirect_to("table list") { tables_path }
    end
  end
end
