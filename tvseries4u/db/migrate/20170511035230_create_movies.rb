class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :gender
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :movies, [:user_id, :created_at]
  end
end
