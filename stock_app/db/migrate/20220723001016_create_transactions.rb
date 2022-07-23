class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :ticker
      t.string :action
      t.integer :shares
      t.datetime :time
      t.integer :user_id

      t.timestamps
    end
  end
end
