class Products < ActiveRecord::Migration
  def self.up
		change_table :products do |t| 
			t.boolean :enabled, :default => false 
		end 
		Product.update_all ["enabled = ?", true] 
  end

  def self.down
  end
end
