class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
      t.string :name
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :club_id

      t.timestamps
    end
  end
end
