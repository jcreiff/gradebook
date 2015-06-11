class SessionsController < ApplicationController
  def login
    if request.post?
      user = set_user(params[:email])
      if user.class == Teacher && user.authenticate(params[:password])
        session[:teacher_id] = user.id
        session[:user_id] = user.id
        redirect_to root_path, notice: "Login Successful."
      elsif user.class == Student && user.authenticate(params[:password])
        session[:student_id] = user.id
        session[:user_id] = user.id
        redirect_to root_path, notice: "Login Successful."
      elsif user.class == Parent && user.authenticate(params[:password])
        session[:parent_id] = user.id
        session[:user_id] = user.id
        redirect_to root_path, notice: "Login Successful."
      else
        flash.now[:notice] = "Invalid Login. Please Try Again."
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:teacher_id] = nil
    session[:student_id] = nil
    session[:parent_id] = nil
    redirect_to sessions_login_path, notice: "Logout Successful."
  end

  def home
  end

end
