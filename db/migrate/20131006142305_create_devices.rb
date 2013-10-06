class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :imei
      t.string :name
      t.datetime :last_seen

      t.timestamps
    end
  end
end
