class StatisticsController < ApplicationController
  def principal
    @movies=Movie.all
    @users=User.all
  end

  def generales
    @movies=Movie.all
    @users=User.all
  end

  def usuario
    @movies=Movie.all
    @users=User.all
  end

  def graficos
    @movies=Movie.all
    @users=User.all
  end

end
