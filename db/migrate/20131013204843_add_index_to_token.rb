class AddIndexToToken < ActiveRecord::Migration
  def self.up

    add_index :users, :authentication_token, :unique => true
  end

 end
