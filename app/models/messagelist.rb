#coding: utf-8
#Messagelistモデル
class Messagelist < ActiveRecord::Base
  
  attr_accessible :expert_id, :user_id
    
  #Userモデルと１対多の関係を結ぶ。
  belongs_to :user

  #Messageモデルと１対多の関係を結ぶ。
  has_many :messages

















end
