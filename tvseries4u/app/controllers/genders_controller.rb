class GendersController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]

  def index
    @gender = Gender.all
  end

  def new
    @gender = Gender.new
  end

  def create
    @gender = current_user.gender.new(gender_params)
    if @gender.save
      flash[:success] = "Género agregado!"
      redirect_to home_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @gender=Gender.all.find(params[:id])
  end

  def destroy
    @gender= Gender.find(params[:id]).destroy
    if @gender.destroy
      flash[:success] = "Género eliminado"
      redirect_to request.referrer || root_url
    else
      flash[:error] = "No se pudo eliminar el género"
      redirect_to request.referrer || root_url
    end
  end

  private

    def gender_params
      params.require(:gender).permit(:name)
    end

    def correct_user
      @gender = current_user.gender.find_by(id: params[:id])
      redirect_to root_url if @gender.nil?
    end
  end
