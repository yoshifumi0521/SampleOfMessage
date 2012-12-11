#coding: utf-8
class MessagesController < ApplicationController
  
     

  def index

    #ログアウトした場合は、このindexアクションをreturnする。
    if !@current_user
      return
    end

    #メッセージの一覧を表示させる処理。


  end


  #メッセージを表示させるメソッド
  def feed 
    
    #エキスパートのidを取得する。
    #@expert_id = params[:id]
    #@expert_name = User.find(@expert_id).name

    #Messagelistモデルを取得する。データがなかったら、データをつくる。
    #@messagelist = @current_user.
    #messagelists.find_or_create_by_expert_id(@expert_id)
    
    #ここでユーザーとエキスパートの画像を取得する。

    

  end


  #メッセージをpostで追加するメソッド。
  def up







  end





  #エキスパートを一覧するメソッド
  def experts
    logger.debug("expertアクション")

    #expertモデルで、ユーザーのidを取得する。
    @current_userId =  @current_user.id.to_s

    #SQL文で、expertの人と、ログインユーザー以外を取り出す。
    @experts = User.find_by_sql(["select * from users 
    WHERE advice = ? and not id = ?",true, @current_userId ]) 


  end











end
