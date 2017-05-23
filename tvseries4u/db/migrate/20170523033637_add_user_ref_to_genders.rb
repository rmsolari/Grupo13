class AddUserRefToGenders < ActiveRecord::Migration[5.0]
  def change
    add_reference :genders, :user, foreign_key: true
  end
end
