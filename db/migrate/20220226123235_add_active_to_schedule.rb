class AddActiveToSchedule < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :active, :integer
    remove_column :schedules, :text, :string
  end
end
