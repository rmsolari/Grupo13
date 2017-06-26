class AddYearToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :year, :integer
  end
end
