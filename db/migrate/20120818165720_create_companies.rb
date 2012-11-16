class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :company_name
      t.string :company_id
      t.string :url

      t.timestamps
    end
    add_index :companies, :company_name
  end

  def self.down
    drop_table :companies
  end
end
