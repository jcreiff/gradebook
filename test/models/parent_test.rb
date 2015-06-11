require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  setup do
    @one = parents(:one)
    @two = parents(:two)
  end

  test "email must be unique" do
    p_one = Parent.new(email: Faker::Internet.email, password: "password",
        name: @one.name, student_id: @one.student_id)
    p_two = Parent.new(email: @two.email, password: "password",
        name: @two.name, student_id: @two.student_id)

    assert p_one.save
    refute p_two.save
  end
end
