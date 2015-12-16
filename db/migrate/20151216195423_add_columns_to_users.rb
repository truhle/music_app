class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string
    add_column :users, :activated, :boolean, default: false
  end
end
