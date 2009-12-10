class ProductsController < UserApplicationController
  inherit_resources # the same as inheriting from InheritedResources::Base

  def autocomplete
    @products = current_restaurant.products.find(:all, :conditions => ['name LIKE ?', "%#{params[:q]}%"])
    respond_to do |format|
      format.json { render :json => @products.collect {|p| {:id => p.id, :text => p.name}}.to_json, :layout => false}
    end
  end

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
