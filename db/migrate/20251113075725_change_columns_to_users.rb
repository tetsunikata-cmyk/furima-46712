class ChangeColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :last_name, false
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name_kana, false
    change_column_null :users, :first_name_kana, false
    change_column_null :users, :birth_date, false
  end
end
