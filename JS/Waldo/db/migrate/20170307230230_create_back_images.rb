class CreateBackImages < ActiveRecord::Migration[5.0]
  def change
    create_table :back_images do |t|
      t.string :title
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
