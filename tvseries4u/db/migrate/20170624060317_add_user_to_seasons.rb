class AddUserToSeasons < ActiveRecord::Migration[5.0]
  def change
    add_reference :seasons, :user, foreign_key: true
  end
end
