class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all.reverse_order
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    else
      if @feed.save
        ContactMailer.contact_mail(@feed).deliver
        redirect_to feeds_path, notice: "作成しました！"
      else
        render :new
      end
    end
  end

  def show
    # @feed = Feed.find(params[:id])
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def edit
    # @feed = Feed.find(params[:id])
  end

  def update
    # @feed = Feed.find(params[:id])
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

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end


  private

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
