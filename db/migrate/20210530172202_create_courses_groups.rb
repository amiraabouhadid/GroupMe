class CreateCoursesGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_groups do |t|
      t.references :course, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
