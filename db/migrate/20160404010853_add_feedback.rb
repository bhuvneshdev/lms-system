class AddFeedback < ActiveRecord::Migration
  def change
  	add_column  :comments, :feedback  ,:text
  end
end
