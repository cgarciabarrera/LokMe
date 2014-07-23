class AddAlarmsToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :alarms, :boolean, :default => false
  end
end
