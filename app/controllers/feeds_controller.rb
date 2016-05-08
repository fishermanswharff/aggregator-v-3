class FeedsController < ApplicationController

  def index
  end

  def create
  end

  def destroy
  end

  private

  def feeds_params
    params.require(:feed).permit(:name, :url)
  end
end
