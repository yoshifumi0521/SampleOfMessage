#coding: utf-8
class MessagesController < ApplicationController
  
     

  def index

    #ログアウトした場合は、このindexアクションをreturnする。
    if !@current_user
      return
    end

    #メッセージの一覧を表示させる処理。
    #ユーザーとエキスパートどっちのメッセージのSessionモデルを取り出す。
    @current_user_id = @current_user.id 
    @sessions = Session.where("user_id = ? or expert_id = ?",@current_user_id,@current_user_id)

    @sessions.each do |session|
      logger.debug(session.messages[0])

    end



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
      #セッションの保存は、メッセージを一つしたら作成する。



    else
      #2回目の場合。
      #今までのメッセージが入った配列のオブジェクト
      @messages = session.messages
    end

    #空のMessageモデルのオブジェクトを作成する。
    @message = Message.new 
    @message.writer_id = current_user_id 

  end


  #メッセージをpostで追加するメソッド。
  def up

    logger.debug(params)
    #エキスパートのidを所得する。
    @expert_id = params[:id]

    #sessionレコードを保存する。
    session = Session.find_or_create_by_user_id_and_expert_id(@current_user.id,@expert_id)

    #messageモデルのオブジェクトを取得する。
    @message = Message.new 
    @message.attributes = params[:message]
    @message.session_id = session.id 
    
    if @message.save
      #feedにリダイレクトする。
      redirect_to feed_message_path(@expert_id)
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
