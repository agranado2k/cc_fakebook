require "test_helper"

module Fakebook
  module Core
    class User
      attr_accessor :username, :friends

      def initialize(username, friends=nil)
        @username = username
        @friends = create_friend_list(friends)
      end

      def create_friend_list(friends)
        friends.nil? ? [] : friends.reduce([]){|l, f| l.push(User.new(f[:username]))}
      end
    end
  end
end

class UserTest < Minitest::Test
  def test_create_user
    username = "username"

    user = Fakebook::Core::User.new(username)

    assert_equal user.username, username
  end

  def test_create_user_with_friends
    username = "username"
    friends = [{username: "f1"},{username: "f2"}]

    user = Fakebook::Core::User.new(username, friends)

    assert_equal user.friends.size, 2
    assert_equal user.friends.first.username, "f1"
  end
end
