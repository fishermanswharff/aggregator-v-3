# Aggregator Version 3

All your news feeds and social media in one place.

Wireframes and schema preparation:
----------------
![wireframes and schema](https://github.com/fishermanswharff/Gator/blob/master/docs/whiteboard-notes.jpg "Whiteboard notes")


```ruby
User
  # table_name :users
  {...user_attributes}
  —————————————————
  has_many :magazines
  has_many :magazines_articles
  has_many :articles, through: :magazines_articles
  has_many :followers, as: :followeable
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy

AuthenticationProvider
  # table_name :authentication_providers
  string :name
  —————————————————
  has_many :user_authentications, dependent: :destroy
  has_many :users, through: :user_authentications

UserAuthentication
  # table_name :user_authentications
  references :user
  references :authentication_provider
  string :uid
  string :token
  datetime :token_expires_at
  hstore :params
  —————————————————
  belongs_to :user
  belongs_to :authentication_provider

Topics
  # table_name :topics
  integer :id
  string :name
  —————————————————
  has_many :feedstopics
  has_many :feeds, through: :feeds_topics
  has_many :articles_topics
  has_many :articles, through: :article_topics

Feed
  # table_name :feeds
  integer :id
  string :url (xml/rss/atom feed url)
  string :name (feed name, derived from feed)
  —————————————————
  has_many :feedstopics
  has_many :topics, through: :feedstopics
  has_many :followers, as: followeable (users)

FeedsTopics
  # table_name :feeds_topics
  integer :id
  integer :topic_id
  integer :feed_id
  belongs_to :topic
  belongs_to :feed
  has_many :followers, as: followeable

ArticlesTopics
  # table_name :articles_topics
  integer :id
  integer :topic_id
  integer :article_id
  —————————————————
  belongs_to :topic
  belongs_to :article
  has_many :followers, as: followeable

Article
  # table_name :articles
  integer :id
  string :url
  string :title (derived from the article)
  integer :feed_id (feed the article comes from)
  —————————————————
  belongs_to :feed
  belongs_to :magazine

Magazine
  # table_name :magazines
  name :string
  references :user
  —————————————————
  belongs_to: user
  has_many :articles
  has_many :followers, as: followeable

MagazinesArticles
  # table_name :magazines_articles
  integer :id
  references :magazine
  references :article
  —————————————————
  belongs_to :magazine
  belongs_to :article

Follower
  # table_name :followers
  data migration something like:
    t.references :followeable, polymorphic: true, index: true
  or:
    string :name
    integer :followable_id
    string :followeable_type #(feed, user, topic, etc.)
  —————————————————
  belongs_to :followeable, polymorphic: true
```

Todos:
* Data model planning
* write migrations
* write models
* controllers
* views
* SSL Cert — basic
* set up elasticache on aws
* get redis up and running
