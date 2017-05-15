class MoviesController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      flash[:success] = "Serie agregada!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @movie = current_user.movies.find(params[:id])
  end

  def destroy
    @movie.destroy
    flash[:success] = "Serie eliminada!"
    redirect_to request.referrer || root_url
  end

  private

    def movie_params
      params.require(:movie).permit(:name, :description, :gender)
    end

    def correct_user
      @movie = current_user.movies.find_by(id: params[:id])
      redirect_to root_url if @movie.nil?
    end
end
