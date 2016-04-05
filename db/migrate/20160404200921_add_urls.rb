class AddUrls < ActiveRecord::Migration
  def change
   	add_column  :posts, :image_url  ,:text
   	add_column  :posts, :video_url  ,:text
  end
end
