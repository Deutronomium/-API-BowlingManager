class AddMissingAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :mail, :string
    add_column :users, :club_id, :integer
  end
end
