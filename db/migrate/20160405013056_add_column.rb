class AddColumn < ActiveRecord::Migration
  def change
  	add_column :posts, :user_id , :integer
  	add_column :comments, :email_id, :string
  end
end
