class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :authentication_provider, index: true, foreign_key: true
      t.string :uid, null: false
      t.string :token, null: false
      t.datetime :token_expires_at
      t.jsonb :params, null: false, default: '{}'
      t.timestamps
    end

    add_index :user_authentications, :params, using: :gin
  end
end
