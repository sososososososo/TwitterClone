class RelationfavoritsController < ApplicationController
  def create
    user = User.find(params[:micropost_id])
    current_user.favorit(user)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to user
  end

  def destroy
    user = User.find(params[:micropost_id])
    current_user.unfavorit(user)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to user
  end
end
