class Customer < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user

  has_many :invoices, dependent: :destroy, inverse_of: :customer
  
#  accepts_nested_attributes_for :invoices, :reject_if => :all_blank, :allow_destroy => true
end
