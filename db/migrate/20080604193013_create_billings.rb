class CreateBillings < ActiveRecord::Migration
  def self.up
    create_table :billings do |t|
      t.string :resourcename

      t.timestamps
    end
  end

  def self.down
    drop_table :billings
  end
end
