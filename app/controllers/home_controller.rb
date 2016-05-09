class HomeController < ApplicationController
  def index
    decorated_user = current_user.decorate if current_user.present?
    render locals: {
      current_user: decorated_user,
      all_feeds: Feed.not_followed(current_user),
      topics: Topic.includes(:feeds).all,
    }
  end
end
