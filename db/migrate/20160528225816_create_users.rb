class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :topics
      t.string :groups
      t.string :zip
      t.timestamps null: false
    end
  end
end
