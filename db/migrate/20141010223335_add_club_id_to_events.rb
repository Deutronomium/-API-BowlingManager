class AddClubIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :club_id, :integer
    add_column :events, :date, :date
  end
end
