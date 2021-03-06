# Adapted from https://github.com/ryanb/cancan/wiki/defining-abilities
class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.superuser?
      can :manage, :all
    else
      can :manage, Customer, user_id: user.id
      can :manage, Invoice, customer: { user_id: user.id } # https://github.com/ryanb/cancan/wiki/Nested-Resources
    end
  end
end
