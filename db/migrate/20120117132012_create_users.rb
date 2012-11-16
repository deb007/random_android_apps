class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_id, :limit => 200
      t.string :full_name, :limit => 250
      t.string :telephone_number, :limit => 30
      t.string :city, :limit => 250
      t.string :country, :limit => 50
      t.string :mail, :limit => 200
      t.string :mobile, :limit => 30
      t.string :hashed_password
      t.string :salt
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.integer :status
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
