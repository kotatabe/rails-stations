class AddUserIdToReservation < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM reservations'
    add_reference :reservations, :user, null: false, index: true
  end
  
  def down
    remove_reference :reservations, :user, index: true
  end
end
