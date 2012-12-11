#coding: utf-8
#Messageモデル
class Message < ActiveRecord::Base
  
  attr_accessible :content, :writer_id,:session_id

  #Sessionモデルと１対多関係を結ぶ。
  belongs_to :session







end
