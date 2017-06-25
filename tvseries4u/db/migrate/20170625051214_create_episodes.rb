class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.integer :numero
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
