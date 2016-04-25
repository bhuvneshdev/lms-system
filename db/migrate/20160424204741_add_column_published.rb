class AddColumnPublished < ActiveRecord::Migration
  def change
  	add_column :posts,:published,:boolean, default: true
  	add_column :posts, :type ,:string
  end
end
