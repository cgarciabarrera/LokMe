class AddIndexToDevicesOnUserId < ActiveRecord::Migration
  def self.up

    add_index :devices, :user_id
  end
end
