class AddTypesBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :types, :integer
  end
end
