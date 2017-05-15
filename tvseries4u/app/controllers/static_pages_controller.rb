class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @movie  = current_user.movies.build
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
