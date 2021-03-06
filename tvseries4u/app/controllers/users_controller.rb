class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :read]
  before_action :correct_user,   only: [:edit, :update, :read]

  def index
    @users = User.all
  end

  def new
    @user=User.new
  end

  def show
    if current_user == User.find(params[:id]) || current_user.admin?
    @user = User.find(params[:id])
    @movies = @user.movies.all
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Bienvenido a TVSeries4u!"
      NotifierMailer.send_signup_email(@user).deliver
      redirect_to @user
    else
      render 'new'
    end
  end

  def create_cuenta_niño
    boy = User.new(:name => params[:boy_name],
    :email => params[:boy_name]+'_niño@tvseries4u.com',
    :password => current_user.password,
    :password_confirmation => current_user.password,
    :adulto_id => current_user.id)
    if boy.save
      flash[:success] = "Cuenta niño creada exitosamente"
      redirect_to boy_accounts_path
    else
      flash[:error] = "No se pudo crear la cuenta niño, prueba cambiando el nombre"
      redirect_to new_boy_creation_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    if @user.destroy
      flash[:success] = "Usuario borrado exitosamente"
      redirect_to request.referrer || users_url
    else
      flash[:error] = "No se pudo borrar el usuario"
      redirect_to request.referrer || users_url
    end
  end

  def genders
    @user=User.find(params[:id])
    @genders=User.find(params[:id]).genders.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Debes ingresar primero al sitio."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
