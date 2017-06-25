class SeasonsController < ApplicationController
	before_action :find_movie
	before_action :find_season, only: [:destroy]

	def index
		@season = Season.all
	end

	def new
		@season = Movie.seasons.new
	end

	def create
		@season = @movie.seasons.create(params[:season])
		@season.number = @movie.seasons.count
		@season.user_id = current_user.id

		if @season.save
			redirect_to movie_path(@movie)
		else
			render 'new'
		end
	end

	def show
		@season = Season.find(params[:id])
		#@season = Season.find_by(movie_id: params[:movie_id])
	end

	def destroy
		@season.destroy
  		redirect_to request.referrer || root_url
	end

	def episode
		@season=Season.all.find(params[:id])
		@episode=@season.episode.find(params[:id])
	end

	private

		def find_season
			@season = Season.find(params[:id])
		end

		def find_movie
			@movie = Movie.find(params[:movie_id])
		end

end
