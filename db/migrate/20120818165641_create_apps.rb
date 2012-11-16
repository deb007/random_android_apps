class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :appname
      t.integer :company_id
      t.string :app_id
      t.string :desc
      t.string :img
      t.string :url

      t.timestamps
    end
    add_index :apps, :app_id
    add_index :apps, :company_id

  end

  def self.down
    drop_table :apps
  end
end
