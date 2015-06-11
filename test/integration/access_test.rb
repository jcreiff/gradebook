require 'test_helper'

class AccessTest < ActionDispatch::IntegrationTest
  test "student can't view or edit other students" do
    get sessions_login_path
    post sessions_login_path, email: "smf@smf.com", password: "studentone"
    assert_redirected_to root_path
    follow_redirect!
    get students_path
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    @student = students(:two)
    get student_path(@student)
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    get edit_student_path(@student)
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    get sessions_logout_path
    follow_redirect!
    assert response.body.match "Logout Successful."
  end

  test "parent can't view or edit other students" do
    get sessions_login_path
    post sessions_login_path, email: "mike@mike.com", password: "parentone"
    assert_redirected_to root_path
    follow_redirect!
    get students_path
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    @student = students(:two)
    get student_path(@student)
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    get edit_student_path(@student)
    assert_redirected_to root_path
    follow_redirect!
    assert response.body.match "Access Denied"
    get sessions_logout_path
    follow_redirect!
    assert response.body.match "Logout Successful."
  end

  test "teachers can view and edit students" do
    get sessions_login_path
    post sessions_login_path, email: "dj@dj.com", password: "teacherone"
    assert_redirected_to root_path
    follow_redirect!
    get students_path
    assert_response :success
    @student = students(:one)
    get student_path(@student)
    assert_response :success
    assert response.body.match "Grades for #{@student.name}"
    get edit_student_path(@student)
    assert_response :success
    get sessions_logout_path
    follow_redirect!
    assert response.body.match "Logout Successful."
  end
end
