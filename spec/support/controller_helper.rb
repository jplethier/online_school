module ControllerHelpers
  def sign_in(user = stub(:user).as_null_object)
    if user.nil?
      request.env['warden'].stub(:authenticate!).and_throw(:warden, { scope: :user })
      controller.stub current_user: nil
    else
      request.env['warden'].stub authenticate!: user
      controller.stub current_user: user
    end
    # controller.stub set_current_account: nil
    # controller.stub set_local_info: nil
    # controller.stub current_account: double('account')
  end

  # def cancan_setup
  #   @ability = Object.new
  #   @ability.extend(CanCan::Ability)
  #   @controller.stub(current_ability: @ability)
  # end

  # def setup_api_request(account)
  #   controller.stub(:authenticate)
  #   controller.stub(:check_user_agent_presence)
  #   controller.stub(current_account: account)

  #   request.env['HTTP_ACCEPT'] = 'application/json'
  # end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers,  type: :controller
  config.include ControllerHelpers,    type: :controller

  # config.before(:each, type: :controller) { cancan_setup }
end