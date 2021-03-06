class GendersController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]

  def index
    @genders = Gender.where(user_id: current_user.id).or(Gender.where(user_id: 1))
  end

  def new
    @gender = Gender.new
    @user=current_user
  end

  def create
    @gender = current_user.genders.new(gender_params)
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
      params.require(:gender).permit(:name).merge(user_id: current_user.id)
    end

    def correct_user
      @gender = current_user.gender.find_by(id: params[:id])
      redirect_to root_url if @gender.nil?
    end
  end
