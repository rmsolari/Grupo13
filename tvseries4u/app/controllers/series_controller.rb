class SeriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @serie = current_user.series.build(serie_params)
    if @serie.save
      flash[:success] = "Serie creada!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @serie.destroy
    flash[:success] = "Serie borrada"
    redirect_to request.referrer || root_url
  end

  private

    def serie_params
      params.require(:serie).permit(:nombre)
    end

    def correct_user
      @serie = current_user.series.find_by(id: params[:id])
      redirect_to root_url if @serie.nil?
    end
end
