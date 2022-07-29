class AddLnameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :lname, :string
  end
end
