class CreateCoursesGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_groups do |t|
      t.belongs_to :course
      t.belongs_to :group
      t.timestamps
    end
  end
end
