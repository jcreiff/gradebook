require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "teacher can login and logout" do
    get sessions_login_path
    assert_select "input[type=password]", 1
    post sessions_login_path, email: "dj@dj.com", password: "teacherone"
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Login Successful."
    get grades_path
    assert_response :success
    get new_grade_path
    assert_response :success
    @student = students(:one)
    post grades_path, grade: {student_id: @student.id, assignment_name: "Quiz", score: 100,
        date: Date.today}
    follow_redirect!
    assert response.body.match "Grade was successfully created."
    get sessions_logout_path
    follow_redirect!
    assert response.body.match "Logout Successful."
  end
end
