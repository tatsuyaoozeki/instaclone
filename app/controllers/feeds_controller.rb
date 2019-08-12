class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      redirect_to feeds_path, notice: "作成しました！"
    else
      render :new
    end
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: "削除しました！"
  end


  private

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
