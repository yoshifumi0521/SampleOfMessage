#coding: utf-8
class Session < ActiveRecord::Base
  
  attr_accessible :expert_id, :status, :thread_id, :user_id

  #Messageモデルと１対多で結ぶ。
  has_many :messages


end
