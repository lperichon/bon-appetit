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
  respond_to :pdf, :only => :show

  def update
    update! do |success, failure|
      success.js { flash[:notice] = t('orders.update.success') }
    end
  end

  def show
    show! do |success, failure|
      success.pdf do
        if @order.closed?
          @order.create_invoice unless @order.invoice
          file_path = RAILS_ROOT + '/public' + @order.invoice.url(:original, false)
          send_file file_path, :type=>"application/pdf"
        else
          flash[:notice] = t('orders.show.pdf.error_order_open')
          redirect_to order_path(@order)
        end
      end
    end
  end

  has_scope :opened, :type => :boolean, :default => true, :only => :index

  protected

  def begin_of_association_chain
    current_restaurant
  end
end