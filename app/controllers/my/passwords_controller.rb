module My
  class PasswordsController < BaseController
    def index
      @user = current_user
    end

    def update
      ChangePassword.new(self).run(params[:user][:password], params[:user][:password_confirmation])
    end

    def password_changed(user)
      @user = user
      flash[:notice] = t("my.passwords.updated")
      render :index
    end

    def password_changed_failed(user)
      @user = user
      flash[:error] = t("my.passwords.passwords_do_not_match")
      render :index
    end
  end
end
