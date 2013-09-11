class Customer < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user

#  has_many :timesheets, dependent: :destroy
  
#  accepts_nested_attributes_for :timesheets, :reject_if => :all_blank, :allow_destroy => true
end
