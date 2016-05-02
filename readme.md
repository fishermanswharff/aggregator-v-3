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
  has_many :followers, as: followeable

AuthenticationProvider
  # table_name :authentication_providers
  string :name

UserAuthentication
  references :user
  references :authentication_provider
  string :uid
  string :token
  datetime :token_expires_at
  string :hstore

Topics
  integer :id
  string :name
  —————————————————
  has_many :feedstopics
  has_many :feeds, through: :feedstopics
  has_many :articles_topics
  has_many :articles, through: :article_topics

Feed
  integer :id
  string :url (xml/rss/atom feed url)
  string :name (feed name, derived from feed)
  —————————————————
  has_many :feedstopics
  has_many :topics, through: :feedstopics
  has_many :followers, as: followeable (users)

FeedsTopics
  integer :id
  integer :topic_id
  integer :feed_id
  belongs_to :topic
  belongs_to :feed
  has_many :followers, as: followeable

ArticlesTopics
  integer :id
  integer :topic_id
  integer :article_id
  —————————————————
  belongs_to :topic
  belongs_to :article
  has_many :followers, as: followeable

Article
  integer :id
  string :url
  string :title (derived from the article)
  integer :feed_id (feed the article comes from)
  —————————————————
  belongs_to :feed
  belongs_to :magazine

Magazine
  name :string
  references :user
  —————————————————
  belongs_to: user
  has_many :articles
  has_many :followers, as: followeable

MagazinesArticles
  integer :id
  references :magazine
  references :article
  —————————————————
  belongs_to :magazine
  belongs_to :article

Follower
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
