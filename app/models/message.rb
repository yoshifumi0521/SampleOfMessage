class Message < ActiveRecord::Base
  belongs_to :session
  attr_accessible :content, :post_id
end
