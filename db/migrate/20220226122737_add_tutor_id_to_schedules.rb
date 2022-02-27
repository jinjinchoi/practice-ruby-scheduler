class AddTutorIdToSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :tutor_id, :integer
    remove_column :schedules, :end_date, :datetime
    remove_column :tutors, :tutor_id, :integer
  end
end
