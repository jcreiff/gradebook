class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logged_in?, except: [:login, :logout]

   def logged_in?
     Teacher.find_by_id(session[:teacher_id]) ? true : (redirect_to sessions_login_path, notice: "Please Login.")
   end

end
