class AddOrderFields < ActiveRecord::Migration
  def self.up
    add_column :image_collections, :display_order,    :integer
    add_column :images, :display_order,    :integer
  end

  def self.down
    remove_column :image_collections, :display_order
    remove_column :images, :display_order
  end
end
