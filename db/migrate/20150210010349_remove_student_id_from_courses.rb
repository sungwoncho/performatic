class RemoveStudentIdFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :student_id, :integer
  end
end
