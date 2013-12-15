class AddRegIdAndroidToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :regid, :string
  end
end
