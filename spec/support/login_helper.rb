module LoginHelper
  include Warden::Test::Helpers

  def login_as_user(user = nil)
    user ||= FactoryGirl.create(:user)

    Capybara.default_host = "http://#{user.account.subdomain}.example.com"
    Capybara.app_host     = "http://#{user.account.subdomain}.lvh.me:31234"

    login_as(user, scope: :user)
  end

  RSpec.configure do |config|
    config.before(:each) do
      Warden.test_mode!
    end

    config.after(:each) do
      Warden.test_reset!

      Capybara.default_host = 'http://www.example.com'
      Capybara.app_host = 'http://www.example.com'
    end
  end
end

