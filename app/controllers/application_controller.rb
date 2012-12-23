#coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  private
  #すべてのコントローラーのアクションの実行時にこの処理を行う。
  def authorize
    
    if cookies.signed[:user_id]
      #ログインユーザーのオブジェクトを@current_user変数にいれる。
      @current_user = User.find_by_id(cookies.signed[:user_id])
      #クッキー情報があったとしても、ユーザー情報がなくてnilだったら、クッキーを削除する。 
      cookies.delete :user_id unless @current_user
    end
  end

  def login_required
    
    #ログインしてなかったら、リダイレクトする。
    return redirect_to :login unless @current_user

  end







end
