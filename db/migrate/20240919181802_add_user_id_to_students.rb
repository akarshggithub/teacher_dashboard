class AddUserIdToStudents < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:students, :user_id)
      add_column :students, :user_id, :integer
      add_index :students, :user_id
      add_foreign_key :students, :users
    end
  end
end
