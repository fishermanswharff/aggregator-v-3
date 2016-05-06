class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.belongs_to :user
      t.references :followable, polymorphic: true, index: true
      t.timestamps
    end

    add_index :followers,
      [:user_id, :followable_id, :followable_type],
      name: 'index_followers_on_user_followable_id_followable_type',
      unique: true
  end
end
