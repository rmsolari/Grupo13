class AddViewersToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :viewers, :array
  end
end
