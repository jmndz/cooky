class Users::SessionsController < Devise::SessionsController
  def new
    @user = User.new
  end

  def create
    self.resource = warden.authenticate(auth_options)

    if resource && resource.active_for_authentication?
      redirect_to recipes_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    super
  end
end