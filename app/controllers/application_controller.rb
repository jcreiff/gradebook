class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logged_in?, except: [:login, :logout]

  def logged_in?
    session[:user_id] ? true : (redirect_to sessions_login_path, notice: "Please Login.")
  end

  def set_user(email)
    if Teacher.find_by_email(email)
      Teacher.find_by_email(email)
    elsif Student.find_by_email(email)
      Student.find_by_email(email)
    elsif Parent.find_by_email(email)
      Parent.find_by_email(email)
    else
      return false
    end
  end

  def check_teacher?
    if session[:teacher_id]
      return true
    else
      redirect_to root_path, notice: 'Access Denied'
    end
  end
end
