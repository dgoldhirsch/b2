class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :superuser

  # attr_accessible :title, :body

  has_many :customers
  has_many :invoices, through: :customers

  def authorized_customers
    if superuser?
      Customer.where(true) # return as AREL, to be consistent with...
    else
      customers # ...the plain, has_many association
    end
  end
end
