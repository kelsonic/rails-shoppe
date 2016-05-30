module UsersHelper
  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def is_admin?
    if current_user.nil? || (current_user.admin == false)
      admin_error
    end
  end

  private
    def admin_error
      flash[:errors] = ["You must be an admin to access this content."]
      redirect_to root_path
    end
end
