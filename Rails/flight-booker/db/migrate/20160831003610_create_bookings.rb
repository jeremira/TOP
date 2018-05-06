class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :flight, foreign_key: true
      t.integer :passenger_number

      t.timestamps
    end
  end
end
