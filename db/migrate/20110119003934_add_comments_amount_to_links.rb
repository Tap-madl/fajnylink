class AddCommentsAmountToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :comments_amount, :integer
  end

  def self.down
    remove_column :links, :comments_amount
  end
end
