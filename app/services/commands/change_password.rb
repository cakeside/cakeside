class ChangePassword
  def initialize(context, current_user = context.current_user)
    @context = context
    @current_user = current_user
  end

  def run(password, password_confirmation)
    if @current_user.change_password(password, password_confirmation)
      @context.password_changed(@current_user)
    else
      @context.password_changed_failed(@current_user)
    end
  end
end
