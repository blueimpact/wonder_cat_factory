class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:is_admin?)
      can :access, :admin
      can :manage, :all
    end

    if user.try(:is_seller?)
      can :access, :seller
      can :manage, Product, user_id: user.id
    end

    can [:index, :show], Product
  end
end
