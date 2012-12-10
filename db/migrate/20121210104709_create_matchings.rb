class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.references :user
      t.references :messagelist

      t.timestamps
    end
    add_index :matchings, :user_id
    add_index :matchings, :messagelist_id
  end
end
