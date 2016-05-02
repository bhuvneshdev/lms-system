class ChangeColumnRatingToFloat < ActiveRecord::Migration
  def change
  	change_column :books, :rating, :float, default: 1
  end
end
