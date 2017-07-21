require "test_helper"

class UserTest < Minitest::Test
  def test_create_user
    args = {username: "username"}
    username = "username"

    user = Fakebook::Core::User.new(args)

    assert_equal user.username, username
  end

  def test_create_user_with_friends
    args = {username: "username", friends: [{username: "f1"},{username: "f2"}]}
    username = "username"
    friends = [{username: "f1"},{username: "f2"}]

    user = Fakebook::Core::User.new(args)

    assert_equal user.friends.size, 2
    assert_equal user.friends.first.username, "f1"
  end
end
