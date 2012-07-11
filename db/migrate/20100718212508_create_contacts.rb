class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :nombre
      t.string :ap1
      t.string :ap2
      t.string :email
      t.string :telf
      
    end
  end

  def self.down
    drop_table :contacts
  end
end
