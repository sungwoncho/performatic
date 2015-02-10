class AddEnrollmentsCountToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :enrollments_count, :integer, default: 0, null: false

    Course.connection.execute <<-SQL
      UPDATE courses
      SET enrollments_count =
        (SELECT COUNT(*)
         FROM enrollments
         WHERE course_id = courses.id)
    SQL

  end

  def down
    remove_column :courses, :enrollments_count
  end
end
