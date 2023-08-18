class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.integer :user_id
      t.integer :age
      t.string :kind
      t.string :name

      t.timestamps
    end
  end
end
