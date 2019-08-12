class FeedsController < ApplicationController
  def index
  end

  def new
    @feed = Feed.new
  end

  def create
    Feed.create(feed_params)
    redirect_to new_feed_path
  end


  private

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end
end
