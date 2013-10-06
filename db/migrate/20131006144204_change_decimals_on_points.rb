class ChangeDecimalsOnPoints < ActiveRecord::Migration
  def self.up

    change_column :points, :latitude, :float, {:length => 15, :decimals => 12}
    change_column :points, :longitude, :float, {:length => 15, :decimals => 12}
    change_column :points, :speed, :float, {:length => 15, :decimals => 12}
    change_column :points, :course, :float, {:length => 15, :decimals => 1}
    change_column :points, :height, :float, {:length => 15, :decimals => 12}
    change_column :points, :accuracy, :float, {:length => 15, :decimals => 1}


  end

  def self.down


  end
end
