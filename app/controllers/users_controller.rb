class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update]
# before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "ユーザを登録しました"
    else
      render 'new'
    end
  end

  def show
    @feeds = Feed.where(user_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集しました"
    else
      render :edit
    end
  end




  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    # ログイン中のユーザidと編集したいユーザidが等しくない場合
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user.id)
    end
  end
end
