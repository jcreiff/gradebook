require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  setup do
    @one = teachers(:one)
    @two = teachers(:two)
  end

  test "email must be unique" do
    t_one = Teacher.new(name: @one.name, email: Faker::Internet.email, password_digest: @one.password_digest)
    t_two = Teacher.new(name: @two.name, email: @two.email, password_digest: @two.password_digest)

    assert t_one.save
    refute t_two.save
  end
end
