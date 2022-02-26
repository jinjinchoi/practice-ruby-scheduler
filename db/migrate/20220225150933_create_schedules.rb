class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :tutor, null: false, foreign_key: true
      t.datetime :start_date
      t.integer :active
      t.timestamps
    end
  end
end
