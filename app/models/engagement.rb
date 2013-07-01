class Engagement < ActiveRecord::Base
  attr_accessible :customer_id, :name

  belongs_to :customer
end
