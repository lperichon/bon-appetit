class OrdersController < UserApplicationController
  inherit_resources do
    actions :all, :except => [:index, :edit, :destroy ]
  end

  def index
    @orders = apply_scopes(current_restaurant.orders).all
  end

  respond_to :js, :only => :update

  has_scope :opened, :type => :boolean, :default => true

  protected

  def begin_of_association_chain
    current_restaurant
  end
end