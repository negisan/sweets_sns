module ControllerMacros
  def login_admin(admin)
    @request.env["devise.mapping"] = Devise.mapping[:admin]
    sign_in admin
  end

  def login_user(user)
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mapping[:user]
    sign_in user
  end
end