class RenameMoviePostUrlToPosterUrl < ActiveRecord::Migration[7.0]
  def change
    rename_column(:movies, :post_url, :poster_url)
  end
end
