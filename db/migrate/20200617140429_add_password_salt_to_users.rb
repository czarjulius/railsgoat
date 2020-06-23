class AddPasswordSaltToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_salt, :text
  end
end
