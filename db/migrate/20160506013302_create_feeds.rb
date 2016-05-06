class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.text :name, null: false, default: ''
      t.text :url, null: false, default: ''
      t.text :description, null: false, default: ''
      t.timestamps
    end

    add_index :feeds, :name
    add_index :feeds, :url
    add_index :feeds, [:url, :name], unique: true
  end
end
