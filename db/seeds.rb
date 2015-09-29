# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

8.times do

  teacher = Teacher.create!(name: Faker::Name.name, email: Faker::Internet.email, password: "test")

  (18..24).to_a.sample.times do
    student = Student.create!(teacher_id: teacher.id, name: Faker::Name.name, email: Faker::Internet.email, password: "test")
    [1, 2].sample.times do
      Parent.create!(student_id: student.id, name: Faker::Name.name, email: Faker::Internet.email, password: "test")
    end
  end

  names = ["Exam", "Quiz", "Test", "Essay", "Homework", "Group Project"]

  (10..15).to_a.sample.times do
    assignment = Assignment.create!(teacher_id: teacher.id, name: names.sample,
      date: Faker::Date.between(180.days.ago, Date.today))
    Student.where(teacher_id: teacher.id).each do |student|
      Grade.create!(student_id: student.id, assignment_id: assignment.id,
        score: Faker::Number.number(2))
    end
  end

end
