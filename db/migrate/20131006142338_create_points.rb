class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :latitude
      t.float :longitude
      t.float :speed
      t.float :height
      t.float :course
      t.float :accuracy
      t.string :provider
      t.datetime :timefix

      t.timestamps
    end
  end
end
