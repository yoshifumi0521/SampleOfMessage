class CreateMessagelists < ActiveRecord::Migration
  def change
    create_table :messagelists do |t|
      t.integer :user_id,null: false
      t.integer :expert_id,null: false

      t.timestamps
    end
  end
end
