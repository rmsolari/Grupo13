class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @movie  = current_user.movies.build
      @user=current_user
      @feed_items = Movie.accessible_by(current_ability)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
