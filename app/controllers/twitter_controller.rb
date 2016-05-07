class TwitterController < ApplicationController

  def index
    render locals: { topics: Topic.includes(:feeds).all }
  end
end
