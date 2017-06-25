class EpisodesController < ApplicationController
	before_action :find_season
	before_action :find_episode, only: [:destroy, :vote]


	def index
		@episode = Episode.all
	end

	def new
		@episode = Season.episodes.new
	end

	def vote
		if !current_user.liked? @episode
			@episode.liked_by current_user
		elsif current_user.liked? @episode
			@episode.unliked_by current_user
		end
	end

	def create
		@episode = @season.episodes.create(params[:episode])
		@episode.numero = @season.episodes.count
		@episode.user_id = current_user.id

		if @episode.save
			redirect_to request.referrer
		else
			render 'new'
		end
	end

	def show
		@episode = Episode.find(params[:id])
		#@season = Season.find_by(movie_id: params[:movie_id])
	end

	def destroy
		@episode.destroy
  		redirect_to request.referrer || root_url
	end

	private

		def find_episode
			@episode = Episode.find(params[:id])
		end

		def find_season
			@season = Season.find(params[:season_id])
		end
end
