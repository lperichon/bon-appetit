module ContactsHelper
  def phone_label(phone)
    "#{phone.type ? phone.type.name : nil} - #{phone.number}"
  end

  def address_label(address)
    "#{address.type ? address.type.name : nil} - #{address.full_address}"
  end

  def email_label(email)
    "#{email.type ? email.type.name : nil} - #{email.address}"
  end

  def website_label(website)
    "#{website.type ? website.type.name : nil} - #{website.address}"
  end

  def instant_messenger_label(instant_messenger)
    "#{instant_messenger.type ? instant_messenger.type.name : nil} - #{instant_messenger.protocol ? instant_messenger.protocol.name : nil} - #{instant_messenger.nick}"
  end
end
