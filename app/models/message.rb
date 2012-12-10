#coding: utf-8
#Messageモデル
class Message < ActiveRecord::Base
  
  attr_accessible :content, :writer_id

  #Messagelistモデルと１対多の関係を結ぶ。
  belongs_to :messagelist  









end
