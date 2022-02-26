class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :text

      t.timestamps
    end
  end
end
