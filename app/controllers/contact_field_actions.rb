module ContactFieldActions
  def self.included(base)
    base.class_eval do
      before_filter :load_parent
    end
  end

  def load_parent
    @parent = if params[:contact_id]
      @contact = current_restaurant.contacts.find(params[:contact_id])
    else
      @user = current_restaurant.users.find(params[:user_id])
    end

  end

  def association_name
    self.field_name.pluralize
  end

  def field_name
    self.controller_class_name.chomp("Controller").singularize.underscore
  end

  def create
    @field = @parent.send("#{self.association_name}").new(params[self.field_name.to_sym])

    if @field.save
      flash[:notice] = t(self.association_name + '.create.notice')
      respond_to do |format|
        format.js {}
      end
    else
      # TODO: handle errors via js
    end
  end

  def update
    @field = @parent.send("#{self.association_name}").find(params[:id])

    @field.attributes = params[self.field_name.to_sym]
    if @field.save
      flash[:notice] = t(self.association_name + '.update.notice')

      respond_to do |format|
        format.js {}
      end
    end
  end
end