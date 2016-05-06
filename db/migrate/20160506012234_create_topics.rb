class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, null: false, default: ''
      t.timestamps
    end

    add_index :topics, :name
  end
end
