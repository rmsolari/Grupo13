class VisitorController < ApplicationController
  def action
    @movies = Movie.where(user_id: 1).all
    render "visitor_view"
  end
end
