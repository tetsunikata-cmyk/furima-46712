class AddNicknameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname, :string, null: false
  end
end
