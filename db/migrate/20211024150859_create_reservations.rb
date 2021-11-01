class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations, auto_increment: true, null: false do |t|
      t.date :date, null: false
      t.references :schedule, null: false, 
                              index: { name: 'reservation_schedule_id_idx'}
      t.references :sheet, null: false,
                            index: { name: 'reservation_sheet_id_idx'}
      t.string :email, :limit => 255, null: false, comment: 'メールアドレス'
      t.string :name, :limit => 50, null: false, comment: '氏名'

      t.timestamps
    end
    add_index :reservations, [:date, :schedule_id, :sheet_id],
                unique: true,
                name: 'reservation_schedule_sheet_unique'
  end
end
