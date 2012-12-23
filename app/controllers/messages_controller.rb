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

    #パスと終了のとき。最新のSessionを取り出す。
    if @status == 2 || @status == 3
      @last_session = Session.where(:user_id => @current_user.id,:expert_id => @partner.id).last if @role == "user"
      @last_session = Session.where(:user_id => @partner.id,:expert_id => @current_user.id).last if @role == "expert"
      
      #最新のSessionがチャット中ならば、flagをtrueにする。
      @flag = true if @last_session.status == 0 || @last_session.status == 1
    end

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


  #メッセージボックスを表示させるためのアクション
  def box
    
    #ユーザーとエキスパートどっちのメッセージのSessionモデルを取り出す。
    @current_user_id = @current_user.id 
    @sessions = Session.where("user_id = ? or expert_id = ?",@current_user_id,@current_user_id)

    #メッセージを仮にいれる配列変数 
    @arrMes = []
    #メッセージの配列の最後のオブジェクトを取り出す。
    @sessions.each do |session|
      #空の場合は取り除く。
      @arrMes <<  session.messages.last  
    end

    #@arrMesをソートする。idの古い順でソート。
    @messages = @arrMes.sort{|a,b|
      b.id <=> a.id
    }



  end






















end
