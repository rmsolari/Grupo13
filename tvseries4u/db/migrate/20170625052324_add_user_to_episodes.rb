class AddUserToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_reference :episodes, :user, foreign_key: true
  end
end
