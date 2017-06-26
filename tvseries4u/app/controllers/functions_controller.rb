class FunctionsController < ApplicationController
  def filtrar
    @directors= Movie.where.not(director: nil)
    @years= Movie.where.not(year: nil)
    if logged_in?
      if not current_user.admin?
        @genders= current_user.genders + Gender.where(:user_id => 1)
      else
        @genders= current_user.genders
      end
    else
      @genders=Gender.where(:user_id => 1)
    end
    @res_g=params[:gender]
    @res_d=params[:director]
    @res_y=params[:year]
    if @res_g[:id].present? and @res_d[:id].present? and @res_y[:id].present?
      puts "entra 1"
      @gender=Gender.find(params[:gender][:id])
      @movies=Movie.where(gender: @gender[:name], id: params[:director][:id], id: params[:year][:id])
    elsif @res_g[:id].present? and @res_d[:id].present?
      puts "entra 2"
      @gender=Gender.find(params[:gender][:id])
      @movies=Movie.where(gender: @gender[:name], id: params[:director][:id])
    elsif @res_g[:id].present? and @res_y[:id].present?
      puts "entra 3"
      @gender=Gender.find(params[:gender][:id])
      @movies=Movie.where(gender: @gender[:name], id: params[:year][:id])
    elsif @res_d[:id].present? and @res_y[:id].present?
      puts "entra 4"
      @movies=Movie.where(id: params[:director][:id], id: params[:year][:id])
    elsif @res_d[:id].present?
      puts "entra 5"
      @movies=Movie.where(id: params[:director][:id])
    elsif @res_g[:id].present?
      puts "entra 6"
      @gender=Gender.find(params[:gender][:id])
      @movies=Movie.where(gender: @gender[:name])
    elsif @res_y[:id].present?
      puts "entra 7"
      @movies=Movie.where(id: params[:year][:id])
    end

  end

  def search
  end
end
