#coding: utf-8
#ログインするときのコントローラー
class SessionsController < ApplicationController

  #applicationコントローラーのauthorizeメソッドは実行しないようにする。
  skip_before_filter :authorize

  def create
    
    @user = User.find_by_name_and_password(params[:name],params[:password])
    logger.debug(@user.inspect)
    
    if !@user
      redirect_to :root
    else
      #ここでクッキーをいれる。
      cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now } 
      redirect_to :root
    end


  end

  #クッキーを削除する。  
  def destroy
  
    if cookies.signed[:user_id] == params[:id].to_i
      #クッキーを削除する。
      cookies.delete :user_id
      redirect_to :root
    end

  end




end
