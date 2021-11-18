class RemoveScreenIdFromSchedule < ActiveRecord::Migration[6.1]
  def change
    remove_reference :schedules, :screen
  end
end
