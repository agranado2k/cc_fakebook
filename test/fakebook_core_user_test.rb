require "test_helper"

class UserTest < Minitest::Test
  def setup
    @dump_db = Fakebook::Core::DumpDB.new
  end

  def test_create_user
    args = {username: "username"}
    username = "username"

    user = Fakebook::Core::User.new(args, @dump_db)

    assert_equal user.username, username
  end

  def test_create_user_with_friends
    args = {username: "username", friends: [{username: "f1"},{username: "f2"}]}
    username = "username"
    friends = [{username: "f1"},{username: "f2"}]

    user = Fakebook::Core::User.new(args, @dump_db)

    assert_equal user.friends.size, 2
    assert_equal user.friends.first.username, "f1"
  end

  def test_add_payment
    value = 11.12
    userA = Fakebook::Core::User.new({username: "userA"}, @dump_db)
    userB = Fakebook::Core::User.new({username: "userB"}, @dump_db)
    payment = Fakebook::Core::Payment.new(value, userB)

    userA.add_payment(payment)

    assert_equal userA.payments.size, 1
    assert_equal userA.payments.first, payment
  end
end
