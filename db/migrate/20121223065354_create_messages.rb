class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :session
      t.integer :post_id
      t.string :content

      t.timestamps
    end
    add_index :messages, :session_id
  end
end
