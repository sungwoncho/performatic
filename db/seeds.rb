# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "faker"

case Rails.env
when 'production'
  puts "Creating students..."

  20.times do
    Student.create!(
      name: Faker::Name.name
    )
  end

  puts "Creating teachers..."

  5.times do
    Teacher.create!(
      name: Faker::Name.name
    )
  end

  puts "Created #{Teacher.count} teachers."

  puts "Creating courses..."

  20.times do
    Course.create!(
      name: Faker::Company.catch_phrase,
      description: Faker::Lorem.paragraphs,
      teacher_id: (1..500).to_a.sample
    )
  end

  puts "Created #{Course.count} courses."

  puts "Enrolling students... It might take up to 10 minutes."

  Student.all.each do |student|
    Course.all.shuffle[1..10].each do |course|
      student.courses << course
    end
  end

  puts "Created #{Enrollment.count} enrollments."


else
  puts "Creating students..."

  8000.times do
    Student.create!(
      name: Faker::Name.name
    )
  end

  puts "Created #{Student.count} students."

  puts "Creating teachers..."

  500.times do
    Teacher.create!(
      name: Faker::Name.name
    )
  end

  puts "Created #{Teacher.count} teachers."

  puts "Creating courses..."

  300.times do
    Course.create!(
      name: Faker::Company.catch_phrase,
      description: Faker::Lorem.paragraphs,
      teacher_id: (1..500).to_a.sample
    )
  end

  puts "Created #{Course.count} courses."

  puts "Enrolling students... It might take up to 10 minutes."

  Student.all.each do |student|
    Course.all.shuffle[1..10].each do |course|
      student.courses << course
    end
  end

  puts "Created #{Enrollment.count} enrollments."
end
