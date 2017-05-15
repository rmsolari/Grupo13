class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin? 
        can :manage, :all

    else
        can :read, Movie, :user => user
        can :read, Movie, :user_id => 1
    end
  end
end
