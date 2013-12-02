class Invoice < ActiveRecord::Base
  attr_accessible :name
  belongs_to :customer, inverse_of: :customer
  has_one :user, through: :customer
end
