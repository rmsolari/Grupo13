class FunctionsController < ApplicationController
  def filtrar
    if logged_in?
      if not current_user.admin?
        @genders= current_user.genders + Gender.where(:user_id => 1)
      else
        @genders= current_user.genders
      end
    else
      @genders=Gender.where(:user_id => 1)
    end
  end

  def search
  end
end
