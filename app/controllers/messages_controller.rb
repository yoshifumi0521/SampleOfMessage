#coding: utf-8
class MessagesController < ApplicationController
  
  
  def index

    #ログアウトした場合は、このindexアクションをreturnする。
    if !@current_user
      return
    end

  
  
  end


  def experts
    logger.debug("expertアクション")

    #expertモデルで、ユーザーのidを取得する。
    @current_userId =  @current_user.id.to_s

    #SQL文で、expertの人と、ログインユーザー以外を取り出す。
    @experts = User.find_by_sql(["select * from users 
    WHERE advice = ? and not id = ?",true, @current_userId ]) 


  end











end
