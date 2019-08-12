class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.create(feed_params)
    if @feed.save
      redirect_to feeds_path, notice: "作成しました！"
    else
      render :new
    end
  end

  def show
    @feed = Feed.find(params[:id])
  end


  private

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end
end
