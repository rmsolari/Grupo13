class EpisodesController < ApplicationController
	before_action :find_season

	def index
		@episode = Episode.all
	end

	def new
		@episode = Season.episodes.new
	end

	def create
		@episode = @season.episodes.create(params[:episode])
		@episode.user_id = current_user.id

		if @episode.save
			redirect_to @season_path(@season)
		else
			render 'new'
		end		
	end

	def show
		@episode = Episode.find(params[:id])
		#@season = Season.find_by(movie_id: params[:movie_id])
	end

	private

		def find_episode
			@episode = Episode.find(params[:id])
		end

		def find_season
			@season = Season.find(params[:season_id])
		end
end
