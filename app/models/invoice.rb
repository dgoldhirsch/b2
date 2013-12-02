class Invoice < ActiveRecord::Base
  attr_accessible :name
  belongs_to :customer
end
