class MoviesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash[:success] = "Serie agregada!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @movie.destroy
    flash[:success] = "Serie eliminada!"
    redirect_to request.referrer || root_url
  end

  private

    def movie_params
      params.require(:serie).permit(:nanem, :description, :gender)
    end

    def correct_user
      @movie = current_user.movies.find_by(id: params[:id])
      redirect_to root_url if @movie.nil?
    end
end
