class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    build_resource(sign_up_params)

    if resource.valid?
      resource.save
      sign_in resource
      redirect_to recipes_path
    else
      @user = resource
      redirect_back fallback_location: new_user_registration_path
    end
  end

  private

  def sign_up_params
    params.require(:user)
      .permit(
        :email, 
        :name, 
        :password, 
        :password_confirmation,
        :agreed_to_terms_and_conditions,
        :agreed_to_privacy_and_policy
      )
  end
end
