#coding: utf-8
class MessagesController < ApplicationController
  
  #メッセージを表示させる。
  def index
 
    #Sessionオブジェクトをとりだす。
    @session = Session.find_by_id(params[:session_id]) 
    return raise ActiveRecord::RecordNotFound unless @session
    @status = @session.status

    #sessionモデルの中にログインユーザーがはいってなかったら、エラー
    return raise unless @session.user_id == @current_user.id || @session.expert_id == @current_user.id 

    #ユーザー側かエキスパート側かを判定する。
    @role = "user" if @session.user_id == @current_user.id
    @role = "expert" if @session.expert_id == @current_user.id
  
    @partner = User.find_by_id(@session.expert_id) if @role == "user"
    @partner = User.find_by_id(@session.user_id) if @role == "expert"

    #メッセージを取り出す。
    @messages = @session.messages

    #空のメッセージのオブジェクトをつくる。
    @post = Message.new
    @post.post_id = @current_user.id
    @post.session_id = @session.id 

  end

  #メッセージが投稿されたらする処理。   
  def create
    
    #メッセージ内容をとりだす。
    @content = params[:message][:content]
    #contentの中身がからだったら、もどる。
    return redirect_to request.env["HTTP_REFERER"] if @content == ""

    @post = Message.new
    @post.attributes = params[:message]

    if @post.save
      
      #5メッセージを超えたらする処理。
      @session = @post.session
      if @session.messages.size == 5
        @session.status = 1
        @session.save
      end

      #message/indexに戻る。
      redirect_to request.env["HTTP_REFERER"]
      return 
    else 
      #エラー処理をする。
      raise
      return
    end
  
  end

























end
