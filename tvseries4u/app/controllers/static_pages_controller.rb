class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @serie  = current_user.series.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
