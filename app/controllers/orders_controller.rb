class OrdersController < UserApplicationController
  inherit_resources do
    actions :all, :except => [:index, :edit, :destroy ]
  end

  def index
    @search = current_restaurant.orders.search(params[:search])
    if params[:search]
      @orders = @search.all
    else
      @orders = apply_scopes(current_restaurant.orders).all
    end

  end

  respond_to :js, :only => :update

  def update
    update! do |success, failure|
      success.js { flash[:notice] = t('orders.update.success') }
    end
  end

  has_scope :opened, :type => :boolean, :default => true, :only => :index

  protected

  def begin_of_association_chain
    current_restaurant
  end
end