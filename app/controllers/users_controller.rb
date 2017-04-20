class UsersController < ApplicationController
before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.all.page(params[:page])
    #ページネーションを適用させるため.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  #-------------------------------------------------------------フォロー系
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  #-------------------------------------------------------------お気に入り系
  def favoritings
    @user = User.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
    counts(@user)
  end
  
  def favoriters
    @user = User.find(params[:id])
    @favoriters = @user.favoriters.page(params[:page])
    counts(@user)
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
