class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :writer_id
      t.text :content
      t.references :session

      t.timestamps
    end
    add_index :messages, :session_id
  end
end
