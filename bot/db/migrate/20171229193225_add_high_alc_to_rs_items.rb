class AddHighAlcToRsItems < ActiveRecord::Migration[5.1]
  def self.up
    add_column :rs_items, :high_alc, :integer
  end
  def self.down
    remove_column :rs_items, :high_alc
  end
end
