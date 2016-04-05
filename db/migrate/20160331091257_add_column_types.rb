class AddColumnTypes < ActiveRecord::Migration
  def change
  	add_column :books, :view_count, :integer
  	# add_column :books, :types, :string
  end
end
