require "test_helper"

class UserTest < Minitest::Test
  def test_create_user
    args = {
      username: "username",
      credentials: {
        username: "user",
        apikey: "apikey"
      }
    }
    username = "username"

    user = Fakebook::Core::User.new(args)

    assert_equal user.username, username
    assert_equal user.credentials[:username], "user"
    assert_equal user.credentials[:apikey], "apikey"
  end
end
