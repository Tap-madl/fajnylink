class AddPrivateToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :private, :boolean, :default => false
  end

  def self.down
    remove_column :links, :private
  end
end
