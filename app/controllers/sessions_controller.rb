#coding: utf-8
class SessionsController < ApplicationController
  
  #ログインされてるかどうかを判定する。
  before_filter :login_required
  
  def index
  
  
  
  
  end

  
  def show
  
  
  
  
  end

  #新しいセッションをつくるときのアクション 
  def new
    
    #エキスパートのidをいれる。
    @expert_id = params[:q]
    #エキスパートの情報をとる。
    @expert = User.find_by_id_and_advice(@expert_id,true)

    #一番新しいセッションを取り出す。
    @last_session = Session.where(:user_id => @current_user.id,:expert_id => @expert_id).last
    
    #一番新しいセッションがなかったら、新しいセッションをつくる。
    @session = Session.new(:user_id => @current_user.id,:expert_id => @expert_id,:thread_id => 1) unless @last_session 

    #一番新しいセッションのstatusが0か1だったら、エラーを起こす。
    return raise if @last_session && (@last_session.status == 0 || @last_session.status == 1 )

    #新しいセッションをつくる。
    @session = Session.new(:user_id => @current_user.id,:expert_id => @expert_id,:thread_id => @last_session.thread_id + 1 ) if @last_session

     
  end

  #新しいセッションでメッセージをやりとりしたときのアクション
  def create

    #メッセージ内容をとりだす。
    @content = params[:content]
    #contentの中身がからだったら、もどる。
    return redirect_to request.env["HTTP_REFERER"] if @content == ""

    #セッションの情報を取得する。
    @session = Session.new
    @session.attributes = params[:session]

    #保存する。されなかったら、エラーを起こす。
    return raise unless @session.save

    @message = @session.messages.new(:post_id => @current_user.id,:content => @content)
    if @message.save
      #保存されたらする処理。Messageリソースにとぶ。
      redirect_to session_messages_path(@session.id)       
      return
    else
      #エラー処理を起こす。
      raise
      return
    end



  end




  












end
