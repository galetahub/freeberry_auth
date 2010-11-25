class FreeberryCreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :auth_accounts do |t|
      t.string   "name"
      t.string   "username"
      t.string   "identifier",    :limit => 90,  :null => false
      t.string   "provider_name", :limit => 100, :null => false
      t.string   "email"
      t.string   "gender",        :limit => 30
      t.date     "birthday"
      t.string   "phone"
      t.string   "photo"
      t.text     "address"
      t.string   "language"
      t.integer  "uid",           :limit => 8
      
      t.timestamps
    end
    
    add_index :auth_accounts, :identifier, :name => "idx_accounts_identifier"
  end

  def self.down
    drop_table :auth_accounts
  end
end
