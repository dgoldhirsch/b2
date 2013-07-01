class Customer < ActiveRecord::Base
  attr_accessible :name, :engagements_attributes

  has_many :engagements, dependent: :destroy
  
  accepts_nested_attributes_for :engagements, :reject_if => :all_blank, :allow_destroy => true
end
