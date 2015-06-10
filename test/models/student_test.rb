require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @one = students(:one)
    @two = students(:two)
  end

  test "email must be unique" do
    s_one = Student.new(email: Faker::Internet.email, password_digest: @one.password_digest,
        name: @one.name, teacher_id: @one.teacher_id)
    s_two = Student.new(email: @two.email, password_digest: @two.password_digest,
        name: @two.name, teacher_id: @two.teacher_id)

    assert s_one.save
    refute s_two.save
  end
end
