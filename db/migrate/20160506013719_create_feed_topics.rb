class CreateFeedTopics < ActiveRecord::Migration
  def change
    create_table :feed_topics do |t|
      t.belongs_to :feed, index: true, foreign_key: true
      t.belongs_to :topic, index: true, foreign_key: true
      t.timestamps
    end
  end
end
