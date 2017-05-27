class AddGenderRefToMovies < ActiveRecord::Migration[5.0]
  def change
    add_reference :movies, :gender, foreign_key: true
  end
end
