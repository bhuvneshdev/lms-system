class AddTypesBooking < ActiveRecord::Migration
  def change
  	add_column :books, :types, :integer
  end
end
