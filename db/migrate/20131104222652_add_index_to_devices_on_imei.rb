class AddIndexToDevicesOnImei < ActiveRecord::Migration
  def self.up

    add_index :devices, :imei
  end
end
