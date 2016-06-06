class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.boolean :attending
      t.string :rsvps
      t.string :priority
      t.string :topic
      t.string :group

      t.timestamps null: false
    end
  end
end
