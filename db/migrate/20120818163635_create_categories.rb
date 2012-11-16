class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :category_name
      t.string :category_id

      t.timestamps
    end
    add_index :categories, :category_name

  end

  def self.down
    drop_table :categories
  end
end
