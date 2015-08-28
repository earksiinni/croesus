class CreateLocalCredentials < ActiveRecord::Migration
  def change
    create_table :local_credentials do |t|
      t.string     :username, null: false, index: true
      t.string     :encrypted_password, null: false
      t.string     :salt, null: false
      t.references :authenticatable, polymorphic: true, null: false
      t.timestamps null: false
    end
    add_index :local_credentials, [:authenticatable_type, :authenticatable_id], unique: true, name: 'index_local_credentials_on_authenticatable'
  end
end
