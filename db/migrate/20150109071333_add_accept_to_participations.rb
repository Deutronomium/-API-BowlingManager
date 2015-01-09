class AddAcceptToParticipations < ActiveRecord::Migration
  def change
  	add_column :participations, :accpet, :boolean
  end
end
