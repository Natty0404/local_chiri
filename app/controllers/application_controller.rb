class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      new_post_path
      flash[:notice] = "ログインしました"
    end

    def after_sign_out_path_for(resource)
      root_path
      flash[:notice] = "ログアウトしました"
    end


    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

end
