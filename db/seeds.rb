# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teacher = Teacher.create!(name: "Test Teacher", email: "test@teacher", password: "test")
student = Student.create!(teacher_id: teacher.id, name: "Test Student", email: "test@student", password: "test")
parent = Parent.create!(student_id: student.id, name: "Test Parent", email: "test@parent", password: "test")
grade = Grade.create!(student_id: student.id, assignment_name: "Test", score: 100, date: Date.today)

5.times do
  Teacher.create!(name: Faker::Name.name, email: Faker::Internet.email, password: "test")
end

t_ids = Teacher.all.map {|t| t.id}

50.times do
  Student.create!(teacher_id: t_ids.sample, name: Faker::Name.name, email: Faker::Internet.email, password: "test")
end

s_ids = Student.all.map {|s| s.id}

100.times do
  Parent.create!(student_id: s_ids.sample, name: Faker::Name.name, email: Faker::Internet.email, password: "test")
end

assignments = ["Test", "Essay", "Quiz", "Presentation", "Homework"]

500.times do
  Grade.create!(student_id: s_ids.sample, assignment_name: assignments.sample,
      score: Faker::Number.number(2), date: Faker::Date.between(180.days.ago, Date.today))
end
