class AddTypeBook < ActiveRecord::Migration
  def change
  	add_column :books, :type , :string
  	add_column :books, :sub_type , :string
  end
end
