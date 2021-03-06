class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :clear_oauth_session, unless: :devise_controller?

  REG_WALL_THRESHOLD = 1

  protected

  def clear_oauth_session
    session["devise.twitter_data"] = nil
  end

  def record_pv
    return if user_signed_in?

    if session.key?(:_nonreg_pvs)
      if session[:_nonreg_pvs_expire_at] < Time.current
        session[:_nonreg_pvs] = 1
        session[:_nonreg_pvs_expire_at] = Time.current + 24.hours
        return
      end

      session[:_nonreg_pvs] += 1
      return
    end

    session[:_nonreg_pvs] = 1
    session[:_nonreg_pvs_expire_at] = Time.current + 24.hours
  end

  def set_reg_wall
    @display_reg_wall = !user_signed_in? && session[:_nonreg_pvs].to_i >= REG_WALL_THRESHOLD
  end

  def ga_tracker
    @ga_tracker ||= Staccato.tracker('UA-156425020-1', nil, ssl: true)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :uid, :provider])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :username, :avatar, :age, :gender, children_attributes: [:id, :age, :gender, :nickname, :_destroy]])
  end

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && resource_or_scope.age.blank? && resource_or_scope.gender.blank?
      return onboarding_index_path
    end
    stored_location_for(resource_or_scope) || super
  end
end
