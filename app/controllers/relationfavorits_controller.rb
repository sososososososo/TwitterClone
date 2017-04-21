class RelationfavoritsController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    user=micropost.user
    user = current_user
    #micropost_id = Micropost.find(params[:micropost_id])
    p micropost.id
    p user.id
    current_user.favfavorit(micropost.id , current_user.id )
    #Relationfavorit.find_or_create_by( 1, 2)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to user
  end

  def destroy
    micropost = Micropost.find(params[:id])
    user = User.find(current_user.id)
    user = current_user
    current_user.unfavorit(micropost.id , current_user.id )
    flash[:success] = "お気に入りを解除しました。#{micropost.id}/#{user.id}"
    redirect_to user
  end
end
