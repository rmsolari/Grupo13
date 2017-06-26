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
    puts movie_params[:gender]
    @movie = current_user.movies.new(movie_params)

    if @movie.gender == "new"
      @gender=Gender.new
      @movie.gender=Gender.new
      render 'genders_path'
    else
      if @movie.save
        flash[:success] = "Serie agregada!"+@movie.gender
        redirect_to home_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def mail
    NotifierMailer.send_list(current_user).deliver
    flash[:success] = "Lista de series enviada a "+current_user.email
    redirect_to home_url
  end

  def download
    @user=current_user
    send_data generate_pdf(@user),:type => 'application/pdf',:disposition => "attachment; filename=lista_"+@user.name+".pdf"
  end

  def show
    @movie=Movie.all.find(params[:id])
    @comments=Comment.where(movie_id: @movie).order("created_at DESC")
    @seasons=Season.where(movie_id: @movie).order("created_at ASC")
#   @movie = current_user.movies.find(params[:id])
  end

  def season
    @movie=Movie.all.find(params[:id])
    @season=@movie.season.find(params[:id])
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
      params.require(:movie).permit(:name, :gender, :description, :year, :director, :language)
    end

    def correct_user
      @movie = current_user.movies.find_by(id: params[:id])
      redirect_to root_url if @movie.nil?
    end

    def generate_pdf(user)
      Prawn::Document.new do
        if user.id == 1
          @movies=Movie.all
        else
          @movies=Movie.where(user_id: user.id).or(Movie.where(user_id: 1))
        end
        font "Helvetica", style: :bold
        font_size 20
        text "Lista de series de "+user.name, :align => :center
        text " "
        @movies.each do |movie|
          font "Helvetica", style: :italic
          font_size 15
          text ""+movie.name, :align => :center
          text " "
          font "Helvetica"
          font_size 10
          if movie.gender.present?
            text "Género: #{movie.gender}"
          end
          if movie.description.present?
            text "Descripción: "+movie.description
          end
          text " "
          text " "
        end
      end.render
  end

end
