class SessionsController < ApplicationController
  def login
    if request.post?
      teacher = Teacher.find_by_email(params[:email])
      if teacher && teacher.authenticate(params[:password])
        session[:teacher_id] = teacher.id
        redirect_to root_path, notice: "Login Successful."
      else
        flash.now[:notice] = "Invalid Login. Please Try Again."
      end
    end
  end

  def logout
    session[:teacher_id] = nil
    redirect_to sessions_login_path, notice: "Logout Successful."
  end

end
