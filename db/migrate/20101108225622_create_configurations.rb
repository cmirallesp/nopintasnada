class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
		cfg = Configuration.new
		cfg.key="banner"
		cfg.value="Zapatillas pintadas<br> a mano. Un regalo...<br>¿para ti o para quién?<br>"
		cfg.save
  end

  def self.down
    drop_table :configurations
  end
end
