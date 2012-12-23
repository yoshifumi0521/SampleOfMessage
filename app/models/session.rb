class Session < ActiveRecord::Base
  attr_accessible :expert_id, :status, :thread_id, :user_id
end
