class CreateAppRanks < ActiveRecord::Migration
  def self.up
    create_table :app_ranks do |t|
      t.integer :app_id
      t.integer :category_id
      t.integer :rank

      t.timestamps
    end
    add_index :app_ranks, :app_id
    add_index :app_ranks, :category_id
    add_index :app_ranks, :rank
  end

  def self.down
    drop_table :app_ranks
  end
end
