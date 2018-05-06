class DropBackImages < ActiveRecord::Migration[5.0]
  def change
  	drop_table :back_images
  end
end
