class AddColumns < ActiveRecord::Migration
  def change
  	add_column :books, :rating1, :integer
  	add_column :books, :rating2, :integer
  	add_column :books, :rating3, :integer
  	add_column :books, :rating4, :integer
  	add_column :books, :rating5, :integer
  	add_column :books_ratings, :rating1, :integer
  	add_column :books_ratings, :rating2, :integer
  	add_column :books_ratings, :rating3, :integer
  	add_column :books_ratings, :rating4, :integer
  	add_column :books_ratings, :rating5, :integer
  end
end
