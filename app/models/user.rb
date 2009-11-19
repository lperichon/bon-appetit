class User < ActiveRecord::Base
  contactable
  
  acts_as_authentic do |c|
    c.validates_length_of_login_field_options = {:on => :update, :minimum => 3}
    c.merge_validates_format_of_login_field_options({:on => :update})
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end

  has_many :managed_restaurants, :foreign_key => 'manager_id', :class_name => 'Restaurant'
  has_and_belongs_to_many :restaurants
  validates_presence_of :username, :on => :update
  validates_presence_of :email

  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :middle_name, :last_name, :birthday

  # we need to make sure that either a password or openid gets set when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank?
  end

  # take care of setting any data that you want to happen at signup (aka before activation)
  def signup!(params)
    self.username = params[:user][:username]
    self.email = params[:user][:email]
    save_without_session_maintenance
  end

  # Take care of setting any data that you want to happen at activation.
  def activate!(params)
    self.username = params[:user][:username] if params[:user][:username]
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end

  # Notification delivery methods
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserNotifier.deliver_password_reset_instructions(self)
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    UserNotifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    UserNotifier.deliver_activation_confirmation(self)
  end
end
