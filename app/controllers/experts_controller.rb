#coding: utf-8
#expertコントローラー
class ExpertsController < ApplicationController
  
  def index
    
    #ログアウトした場合は、このindexアクションをreturnする。
    if !@current_user
      return
    end
    #expertモデルで、ユーザーのidを取得する。
    @current_userId =  @current_user.id.to_s

    #SQL文で、expertの人と、ログインユーザー以外を取り出す。
    @experts = User.find_by_sql(["select * from users 
    WHERE advice = ? and not id = ?",true, @current_userId ]) 

    logger.debug(@experts)
  
  end













end
