class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :flight_number
      t.references :departure_airport, foreign_key: true
      t.references :arrival_airport, foreign_key: true
      t.datetime :departure_time
      t.integer :flight_duration

      t.timestamps
    end
  end
end
