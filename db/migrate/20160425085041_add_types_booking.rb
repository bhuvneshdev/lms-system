class AddTypesBooking < ActiveRecord::Migration
  def change
  	add_column :booking, :types, :integer
  end
end
