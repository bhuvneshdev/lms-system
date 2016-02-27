class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :books, :url, :text
  	change_column :books, :image_url, :text
  	change_column :users, :role, :string, default: 'student'
  	add_column :books, :author_name, :string
  end
end
