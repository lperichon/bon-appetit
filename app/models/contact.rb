class Contact < ActiveRecord::Base
  contactable
  belongs_to :restaurant

  named_scope :starts_with, proc {|c| { :conditions => ["first_name LIKE ?", "#{c}%"] } }
end
