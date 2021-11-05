class CreateScreens < ActiveRecord::Migration[6.1]
  def change
    create_table :screens do |t|
      t.integer :number, :limit => 3, null: false
      t.references :movie, null: false

      t.timestamps
    end
  end
end
