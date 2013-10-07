class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_member

  private
  def current_member
    @current_member ||= Member.find(session[:member_id]) if session[:member_id]
  end

  def authenticate
    if !current_member
      session[:source] = request.path
      if session[:source] != "/admin"
        flash[:error] = "You must be an admin to do that!"
        redirect_to "/admin"
      end
    elsif !current_member.admin_id?
      flash[:error] = "You must be an admin to do that!"
      reset_session
      redirect_to :root
    end
  end
end
