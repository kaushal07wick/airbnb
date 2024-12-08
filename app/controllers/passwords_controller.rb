class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update!(password_params)
      redirect_to edit_password_path, notice: "Password updated successfully"
    else
      redirect_back fallback_location: edit_password_path, alert: "Failed to update password, please check again."
    end
  end
  private

  def password_params
    params.require(:user).permit(:password)
  end
end
