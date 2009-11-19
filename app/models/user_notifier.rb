class UserNotifier < ActionMailer::Base
  default_url_options[:host] = "authlogic_example.binarylogic.com"

  def password_reset_instructions(user)
    subject "Password Reset Instructions"
    from "Binary Logic Notifier "
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

end