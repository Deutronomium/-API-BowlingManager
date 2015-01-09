class ParticipationFixColumnName < ActiveRecord::Migration
  def change
  	rename_column :participations, :accpet, :accept
  end
end
