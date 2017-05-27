class CommentsController < ApplicationController
	before_action :find_movie
	before_action :find_comment, only: [:destroy]

	def index
		@comment = Comment.all
	end

	def new
		@comment = Movies.comments.new
	end

	def create
		@comment = @movie.comments.create(params[:comment].permit(:text))
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Comentario añadido exitosamente"
      		redirect_to request.referrer || root_url
		else render 'new'
		end
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def destroy
		@comment.destroy
  		redirect_to request.referrer || root_url
	end

	private

		def commentParams
			params.require(:comment).permit(:comment)
		end	

		def find_movie
			@movie = Movie.find(params[:movie_id])
		end		

		def find_comment
			@comment = @movie.comments.find(params[:id])
		end
end