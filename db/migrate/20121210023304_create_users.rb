class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,null: false
      t.string :uid,null: false
      t.string :password,null: false
      t.boolean :use,default: true
      t.boolean :advice,default: false
    

      t.timestamps
    end
  end
end
