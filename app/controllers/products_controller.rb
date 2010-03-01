class ProductsController < UserApplicationController
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => :edit
  end

  respond_to :js, :only => :update

  def update
    update! do |success, failure|
      success.js { flash[:notice] = t('products.update.success') }
    end
  end

  def autocomplete
    @products = current_restaurant.products.name_or_code_like("#{params[:q]}")
    respond_to do |format|
      format.json { render :json => @products.collect {|p| {:id => p.id, :text => "#{p.code} - #{p.name}"}}.to_json, :layout => false}
    end
  end

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
