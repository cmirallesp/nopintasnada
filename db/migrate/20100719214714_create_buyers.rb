class CreateBuyers < ActiveRecord::Migration
  def self.up
    create_table :buyers do |t|
      t.string :nombre
      t.string :email
      t.string :idioma
      t.string :conocio

      t.timestamps
    end
  end

  def self.down
    drop_table :buyers
  end
end
