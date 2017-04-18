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
  end
  
end