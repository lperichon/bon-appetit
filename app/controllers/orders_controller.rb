class OrdersController < UserApplicationController
  inherit_resources do
    actions :all, :except => [ :edit, :destroy ]
  end

  respond_to :js, :only => :update

  protected

  def begin_of_association_chain
    current_restaurant
  end
end