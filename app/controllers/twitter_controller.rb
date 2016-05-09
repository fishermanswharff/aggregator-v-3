class TwitterController < ApplicationController

  def index
    render locals: {
      topics: Topic.includes(:feeds).all,
      all_feeds: Feed.not_followed(current_user),
    }
  end
end
