class AddParticipationToFinePayment < ActiveRecord::Migration
  def change
    remove_column :fine_payments, :user_id
    remove_column :fine_payments, :event_id
    add_column :fine_payments, :participation_id, :integer
  end
end
