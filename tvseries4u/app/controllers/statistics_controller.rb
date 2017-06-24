class StatisticsController < ApplicationController
  def principal
    @movies=Movie.all
    @users=User.all
  end

  def generales
  end

  def usuario
  end

  def graficos
  end
  
end
