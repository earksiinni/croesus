class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :authenticatable, polymorphic: true, index: true, null: false
      t.string     :secret, null: false
      t.string     :nonce, null: false
      t.string     :token, null: false, index: true
      t.timestamp  :expires_at, null: false, index: true
      t.timestamps null: false
    end
  end
end
