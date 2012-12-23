#coding: utf-8
#ログインするときのコントローラー
class LoginsController < ApplicationController

  #applicationコントローラーのauthorizeメソッドは実行しないようにする。
  skip_before_filter :authorize

  def create
    
    @user = User.find_by_name_and_password(params[:name],params[:password])
    
    return redirect_to :login unless @user
      
    #ここでクッキーをいれる。
    cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now } 
    
    return redirect_to :root
  
  end

  #クッキーを削除する。  
  def destroy
  
    if cookies.signed[:user_id] == params[:id].to_i
      #クッキーを削除する。
      cookies.delete :user_id
      redirect_to :root
      return
    end

  end

  
  def login




  end




end
