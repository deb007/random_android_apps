class CreateAppCategories < ActiveRecord::Migration
  def self.up
    create_table :app_categories do |t|
      t.integer :app_id
      t.integer :category_id

      t.timestamps
    end
    add_index :app_categories, :app_id
    add_index :app_categories, :category_id
  end

  def self.down
    drop_table :app_categories
  end
end
