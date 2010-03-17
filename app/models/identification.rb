class Identification < ActiveRecord::Base

  validates_presence_of :code

  belongs_to            :owner, :polymorphic => true
  belongs_to            :type,  :class_name => 'IdentificationType'
end
