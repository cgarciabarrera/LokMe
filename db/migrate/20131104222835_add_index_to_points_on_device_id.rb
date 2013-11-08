class AddIndexToPointsOnDeviceId < ActiveRecord::Migration
  def self.up

    add_index :points, :device_id
  end
end
