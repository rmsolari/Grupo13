class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?

    else
        can :show, Movie do |movie|
            movie.user == current_user
            if movie.user
        end

        can :show, Movie do |movie|
            if movie.user.admin? 
        end 
  end
end
