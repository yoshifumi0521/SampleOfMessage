class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id,null: false
      t.integer :expert_id,null: false
      t.integer :thread_id,null: false
      t.integer :status,null: false,:default => 0

      t.timestamps
    end
  end
end
