class AddParticipationToDrinkPayment < ActiveRecord::Migration
  def change
    remove_column :drink_payments, :user_id
    remove_column :drink_payments, :event_id
    add_column :drink_payments, :participation_id, :integer
  end
end
