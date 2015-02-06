class AddClubIdToDrink < ActiveRecord::Migration
  def change
    add_column :drinks, :club_id, :integer
  end
end
