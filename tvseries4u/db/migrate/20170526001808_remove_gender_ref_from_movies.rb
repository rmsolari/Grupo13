class RemoveGenderRefFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_reference :movies, :gender, foreign_key: true
  end
end
