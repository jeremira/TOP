class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.integer :attendee
      t.integer :event_attented

      t.timestamps
    end
  end
end
