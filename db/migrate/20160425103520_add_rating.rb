class AddRating < ActiveRecord::Migration
  def change
  	add_column :books, :rating6, :integer, default: 1
  	add_column :books, :rating7, :integer, default: 1
  	add_column :books, :rating8, :integer, default: 1
  	add_column :books_ratings, :rating6, :integer, default: 1
  	add_column :books_ratings, :rating7, :integer, default: 1
  	add_column :books_ratings, :rating8, :integer, default: 1
  end
end
