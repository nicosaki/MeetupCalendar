class AddColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :url, :string
    add_column :events, :name, :string
  end
end
