#coding: utf-8
#Sessionコントローラー
class Session < ActiveRecord::Base
  
  attr_accessible :expert_id, :user_id

  has_many :messages








end
