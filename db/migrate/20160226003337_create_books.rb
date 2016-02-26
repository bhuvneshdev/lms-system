class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :image_url
      t.integer :price
      t.string :category
      t.string :subcategory
      t.integer :rating

      t.timestamps
    end
  end
end
