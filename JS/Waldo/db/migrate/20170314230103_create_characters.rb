class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :descr
      t.string :avatar

      t.timestamps
    end
  end
end
