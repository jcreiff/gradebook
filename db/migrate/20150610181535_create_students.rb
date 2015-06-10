class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :teacher_id
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
