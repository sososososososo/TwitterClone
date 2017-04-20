class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_user_logged_in
    #ログイン状態を確認し、ログインしていれば何もせず、
    #ログインしていなければログインページへ強制的にリダイレクト
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    #@count_favoritings = user.favoritings.count
    #@count_favoriters = user.favoriters.count
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
end