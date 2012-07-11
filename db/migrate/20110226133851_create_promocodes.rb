class CreatePromocodes < ActiveRecord::Migration
  def self.up
    create_table :promocodes do |t|
      t.date :end_date
      t.float :value
      t.boolean :state
      t.integer :days
      t.string :code
      t.date :start_date

      t.timestamps
    end
  end

  def self.down
    drop_table :promocodes
  end
end
