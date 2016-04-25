class AddTypeBook < ActiveRecord::Migration
  def change
  	change_column :books, :type , :string
  	add_column :books, :sub_type , :string
  end
end
