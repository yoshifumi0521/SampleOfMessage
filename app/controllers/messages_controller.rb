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
    expert_id = params[:id]
    #ログインユーザーのidを取得する。
    current_user_id = @current_user.id

    #ここでユーザーとエキスパートの画像を取得する。
    @expert_name = User.find(expert_id).name
    
    #Sessionのオブジェクトを取得する。なかったら、生成する。
    session = Session.find_or_initialize_by_user_id_and_expert_id(current_user_id,expert_id)
   
    #Sessionオブジェクトを生成したかどうかを判定する。
    if session.new_record?
      #セッションがはじめてつくられたらここを通る。
      #sessionを保存する。
      if session.save    
        #保存に成功したらここを通る。
      
      else
        #保存に失敗したらエラー処理。

        
      end
    
    else
      #2回目の場合。
      #今までのメッセージが入った配列のオブジェクト
      @messages = session.messages

    end

    #空のMessageモデルのオブジェクトを作成する。
    @message = Message.new 
    @message.session_id = session.id
    @message.writer_id = current_user_id 
    

  end


  #メッセージをpostで追加するメソッド。
  def up

    #messageモデルのオブジェクトを取得する。
    @message = Message.new     
    @message.attributes = params[:message]

    if @message.save
      
      #feedにリダイレクトする。
      redirect_to feed_message_path([params[:id]])
      return
    
    else
      #エラー処理を行う。

    end


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
