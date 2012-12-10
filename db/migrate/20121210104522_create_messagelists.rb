class CreateMessagelists < ActiveRecord::Migration
  def change
    create_table :messagelists do |t|
      t.integer :user_id
      t.integer :expert_id

      t.timestamps
    end
  end
end
