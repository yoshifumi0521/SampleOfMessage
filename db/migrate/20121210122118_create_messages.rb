class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :writer_id
      t.text :content

      t.timestamps
    end
  end
end
