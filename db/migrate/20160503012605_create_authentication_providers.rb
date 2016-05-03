class CreateAuthenticationProviders < ActiveRecord::Migration
  def change
    create_table :authentication_providers do |t|
      t.string :name, null: false, index: true
      t.timestamps
    end
  end
end
