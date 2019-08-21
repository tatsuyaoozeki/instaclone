class FavoritesController < ApplicationController
  before_action :ensure_correct_user, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの写真をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの写真をお気に入り解除しました"
  end

  def ensure_correct_user
    # ログイン中のユーザidと編集したいユーザidが等しくない場合
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to feed_path
    end
  end
end
