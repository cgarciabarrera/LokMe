class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|

      t.integer :device1
      t.integer :device2
      t.boolean :closer, :default => true
      t.integer :distance
      t.string :tipo
      t.boolean :activa, :default => true
      t.boolean :in_progress, :default => false
      t.timestamps

    end
  end
end
