class AddRsItems < ActiveRecord::Migration[5.1]
  def change
    create_table :rs_items do |t|
      t.string :name
    end
  end
end
