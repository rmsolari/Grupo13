class AddGenderToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :gender, :string
  end
end
