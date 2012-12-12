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

    #メッセージを仮にいれる配列変数 
    @arrMes = [] 
    #メッセージの配列の最後のオブジェクトを取り出す。
    @sessions.each do |session|
      @arrMes <<  session.messages.last
    end

    #@arrMesをソートする。idの古い順でソート。
    @messages = @arrMes.sort{|a,b|
      b.id <=> a.id
    }
    

  end


  #メッセージを表示させるメソッド
  def feed 

    @type = params[:type]
    #ログインユーザーがエキスパートで、セッションがエキスパートとして参加してる場合。
    if @type == "expert"
      
      user_id = params[:id]
      expert_id =@current_user.id
      #相手の名前
      @partner_name = User.find_by_id(user_id).name
    else @type == "user"
    #それ以外
      user_id = @current_user.id
      expert_id = params[:id]
      #相手の名前
      @partner_name = User.find_by_id(expert_id).name
    end
  
    #Sessionのオブジェクトを取得する。なかったら、生成する。
    session = Session.find_or_initialize_by_user_id_and_expert_id(user_id,expert_id)

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
    @message.writer_id = @current_user.id 

  end


  #メッセージをpostで追加するメソッド。
  def up

    @type = params[:type]
    if @type == "expert"
      
      user_id = params[:id]
      expert_id =@current_user.id
      @redirecturl = url_for(:controller => :messages, :action => :feed, :id => user_id, :type => "expert" )  
    else @type == "user"
      #それ以外
      user_id = @current_user.id
      expert_id = params[:id]
      @redirecturl = url_for(:controller => :messages, :action => :feed, :id => expert_id, :type => "user" )  
    end
    
    #sessionレコードを保存する。
    session = Session.find_or_create_by_user_id_and_expert_id(user_id,expert_id)

    #messageモデルのオブジェクトを取得する。
    @message = Message.new 
    @message.attributes = params[:message]
    @message.session_id = session.id 
    
    if @message.save
      #feedにリダイレクトする。
      redirect_to @redirecturl
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
