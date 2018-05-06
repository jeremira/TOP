class CreateFindables < ActiveRecord::Migration[5.0]
  def change
    create_table :findables do |t|
      t.integer :background_id
      t.integer :character_id
      t.integer :locationX
      t.integer :locationY

      t.timestamps
    end
  end
end
