class AddGmapsToDevices < ActiveRecord::Migration

  def self.up
    add_column :devices, :gmaps, :boolean

  end

  def self.down
    remove_column :devices, :gmaps
  end

end
