module TestHelpers
    def login_as(user)
      post login_path, params: { user_number: user.user_number, password: "password" }
    end
end

  RSpec.configure do |config|
    config.include TestHelpers, type: :request
  end
