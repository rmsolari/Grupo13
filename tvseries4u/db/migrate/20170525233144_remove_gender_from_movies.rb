class RemoveGenderFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :gender, :string
  end
end
