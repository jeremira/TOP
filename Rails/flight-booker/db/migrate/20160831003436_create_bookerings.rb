class CreateBookerings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookerings do |t|
      t.integer :passenger_id
      t.integer :booking_id

      t.timestamps
    end
  end
end
