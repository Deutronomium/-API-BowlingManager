class RemoveAcceptFromEventAndAddToParticipations < ActiveRecord::Migration
  def change
    remove_column :events, :accept
  end
end
