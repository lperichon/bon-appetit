# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'product'
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user_session, :current_user, :current_restaurant

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def current_restaurant
      return @current_restaurant if defined?(@current_restaurant)
      @current_restaurant = current_user.restaurants.first
    end

    def require_admin
      if !current_user
        store_location
        flash[:error] = t('common.errors.admin_required')
        redirect_to admin_login_url
        return false
      elsif current_user && !current_user.admin?
        store_location
        flash[:error] = t('common.errors.admin_required')
        redirect_to dashboard_url
        return false
      elsif current_user && current_user.admin?
        return true
      end
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = t('common.notice.session_required')
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = t('common.notice.no_session_required')
        redirect_to dashboard_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
