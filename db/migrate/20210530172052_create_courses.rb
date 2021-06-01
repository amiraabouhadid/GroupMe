class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.references :user, null: false, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
