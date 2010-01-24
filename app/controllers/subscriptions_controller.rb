class SubscriptionsController < UserApplicationController
  before_filter :find_subscription

  def show
  end

  def edit
    # to change plans
    @allowed_plans = @subscription.allowed_plans
  end

  def update
    # find the plan
    plan = SubscriptionPlan.find params[:subscription][:plan_id]
    if plan.nil?
      flash[:notice] = t('subscriptions.update.plan_not_found')
      
    # make sure its an allowed plan
    elsif exceeded = @subscription.exceeds_plan?( plan ) 
      flash[:notice] = t('subscriptions.update.resources_exceeded', :plan_name => plan.name)
      flash[:notice] << ": #{exceeded.keys.join(', ')}" if exceeded.is_a?(Hash)
      
    # perform the change
    # note, use #change_plan, dont just assign it
    elsif @subscription.change_plan(plan)  
      flash[:notice] = t('subscriptions.update.success')
      
      # after change_plan, call renew
      case result = @subscription.renew
      when false
        flash[:notice] << t('subscriptions.update.error_charging')
      when Money
        flash[:notice] << t('subscriptions.update.success_charging', :amount => result.format)
      end
      return redirect_to subscription_path
    end
    
    # failed above for some reason
    @allowed_plans = @subscription.allowed_plans
    render :action => 'edit'
  end

  def cancel
    @subscription.cancel
    flash[:notice] = t('subscriptions.cancel.success')
    redirect_to subscription_path
  end

  # could put these in separate controllers, but keeping it simple for now
	def credit_card
	  @profile = @subscription.profile
	end
	
	def store_credit_card
	  @subscription.profile.credit_card = params[:profile][:credit_card]
	  @subscription.profile.request_ip = request.remote_ip
	  if @subscription.profile.save
	    #debugger
	    case result = @subscription.renew
      when false
        flash[:notice] = t('subscriptions.store_credit_card.error_charging')
      when Money
	      flash[:notice] = t('subscriptions.store_credit_card.success_charging', :amount => result.format)
      else
	      flash[:notice] = t('subscriptions.store_credit_card.success')
      end
	    return redirect_to subscription_path
    else
	    @profile = @subscription.profile
      render :action => 'credit_card'
    end
	end
	
	def history
	  @transactions = @subscription.transactions
	end
	
  private

  def find_subscription
    @subscription = current_restaurant.subscription
  end
end
