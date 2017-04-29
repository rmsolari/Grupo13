class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.text :nombre_serie
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :series, [:user_id, :created_at]
  end
end
