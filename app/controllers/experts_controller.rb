#coding: utf-8
class ExpertsController < ApplicationController

  #ログインされてるかどうかを判定する。
  before_filter :login_required

  def index

    #エキスパートのみ取り出す。ログインユーザーの排除
    @experts = User.where(["advice = ? and id != ?", true, @current_user.id])



  
  end


  #エキスパートの詳細を表示する。
  def show

    @expert = User.find_by_id(params[:id])



  end









end
