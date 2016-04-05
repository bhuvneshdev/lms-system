class ChangeColumnTypes < ActiveRecord::Migration
  def change
  	change_column :books, :rating, :integer
  	add_column :books, :type, :integer
  end
end
