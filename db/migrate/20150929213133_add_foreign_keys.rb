class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :assignments, :date, :date
    add_column :grades, :assignment_id, :integer
    remove_column :grades, :assignment_name, :string
    remove_column :grades, :date, :date
  end
end
