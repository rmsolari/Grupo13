class MoviesController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]

  def new
    @movie = Movie.new
    if not current_user.admin?
      @genders= current_user.genders + Gender.where(:user_id => 1)
    else
      @genders= current_user.genders
    end
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.gender == "new"
      @gender=Gender.new
      @movie.gender=Gender.new
      render 'genders_path'
    else
      if @movie.save
        flash[:success] = "Serie agregada!"
        redirect_to home_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def show
    @movie=Movie.all.find(params[:id])
    @comments=Comment.where(movie_id: @movie).order("created_at DESC")
#  @movie = current_user.movies.find(params[:id])
  end

  def destroy
    @movie= Movie.find(params[:id]).destroy
    if @movie.destroy
      flash[:success] = "Serie eliminada exitosamente"
      redirect_to request.referrer || root_url
    else
      flash[:error] = "No se pudo borrar el usuario"
      redirect_to request.referrer || root_url
    end
  end

  private

    def movie_params
      params.require(:movie).permit(:name, :gender, :description)
    end

    def correct_user
      @movie = current_user.movies.find_by(id: params[:id])
      redirect_to root_url if @movie.nil?
    end

end
