#coding: utf-8
#UserモデルとMessagelistモデルの間を仲介する、仲介モデル。
class Matching < ActiveRecord::Base
  belongs_to :user
  belongs_to :messagelist
  # attr_accessible :title, :body







end
