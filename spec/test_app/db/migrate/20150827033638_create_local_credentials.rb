class CreateLocalCredentials < ActiveRecord::Migration
  def change
    create_table :local_credentials do |t|
      t.string  :username, null: false, index: true
      t.string  :encrypted_password, null: false
      t.string  :salt, null: false
      t.string  :authenticatable_type, null: false, index: true
      t.integer :authenticatable_id, null: false
      t.timestamps
    end
  end
end
