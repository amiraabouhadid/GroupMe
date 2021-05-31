class CreateCoursesGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_groups do |t|
      t.references :course, index: true, null: false, foreign_key: true
      t.references :group, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
