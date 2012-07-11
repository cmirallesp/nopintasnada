class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :model
      t.string :preu
      t.string :descripcio
      t.string :nom
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
