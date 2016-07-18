class TopicsController < ApplicationController
  before_action :load_resources, only: [:show]
  before_action :set_topic, only: [:show]

  def show
    render locals: {
      topic: @topic,
      current_user: @decorated_user,
      all_feeds: Feed.all,
      topics: @topics
    }
  end

  private

  def load_resources
    @topics = Topic.includes(:feeds).all
    @decorated_user = current_user.decorate if current_user.present?
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
