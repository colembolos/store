class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.admin?
      admin_products_path
    else
      products_path
    end
  end
end
