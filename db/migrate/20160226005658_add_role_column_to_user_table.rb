class AddRoleColumnToUserTable < ActiveRecord::Migration
  def change
  	add_column :users, :role, :integer , default: 0
  	add_column :users, :preferences, :string
  	add_column :users, :author_name, :string
  end
end
