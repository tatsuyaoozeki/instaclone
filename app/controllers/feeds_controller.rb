class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    Feed.create(feed_params)
    redirect_to new_feed_path
  end

  def show
    @feed = Feed.find(params[:id])
  end


  private

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end
end
