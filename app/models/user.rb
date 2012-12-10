#coding: utf-8
#Userモデル
class User < ActiveRecord::Base
  
  attr_accessible :advice, :name, :uid, :use

  #Messagelistモデルと一対多の関係を結ぶ。
  has_many :messagelists    
















end
