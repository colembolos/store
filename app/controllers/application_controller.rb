class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.admin?
      admin_products_path
    else
      products_path
    end
  end

  private

  def current_admin!
    redirect_to(root_path, alert: "Not authorized") unless current_user.admin?
  end

  def current_normal_user!
    redirect_to(root_path, alert: "Not authorized") unless current_user.user?
  end
end
