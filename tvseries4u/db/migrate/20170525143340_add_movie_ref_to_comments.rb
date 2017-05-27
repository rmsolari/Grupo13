class AddMovieRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :movie, foreign_key: true
  end
end
