class CreateFinePayment < ActiveRecord::Migration
  def change
    create_table :fine_payments do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.belongs_to :fine

      t.timestamps
    end
  end
end
