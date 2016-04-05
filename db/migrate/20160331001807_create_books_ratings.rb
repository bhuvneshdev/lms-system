class CreateBooksRatings < ActiveRecord::Migration
  def change
    create_table :books_ratings do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer  :rating
      t.timestamps
    end
  end
end
