class AddAcceptToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :accept, :boolean
  end
end
