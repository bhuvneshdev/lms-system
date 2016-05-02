class ChangeRatinggs < ActiveRecord::Migration
  def change
  	change_column :books, :rating1, :integer, default: 1
  	change_column :books, :rating2, :integer, default: 1
  	change_column :books, :rating3, :integer, default: 1
  	change_column :books, :rating4, :integer, default: 1
  	change_column :books, :rating5, :integer, default: 1
  	change_column :books_ratings, :rating1, :integer, default: 1
  	change_column :books_ratings, :rating2, :integer, default: 1
  	change_column :books_ratings, :rating3, :integer, default: 1
  	change_column :books_ratings, :rating4, :integer, default: 1
  	change_column :books_ratings, :rating5, :integer, default: 1
  end
end
