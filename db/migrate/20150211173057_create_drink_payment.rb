class CreateDrinkPayment < ActiveRecord::Migration
  def change
    create_table :drink_payments do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.belongs_to :drink

      t.timestamps
    end
  end
end
