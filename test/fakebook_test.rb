require "minitest/autorun"


module Fakebook
  class User
    attr_accessor :username, :friends

    def initialize(username, friends=nil)
      @username = username
      @friends = create_friend_list(friends)
    end

    def create_friend_list(friends)
      list = []
      friends.each do |f|
        list.push(User.new(f))
      end
      list
    end
  end
end

class UserTest < Minitest::Test
  def test_create_user
    username = "username"

    user = Fakebook::User.new(username)

    assert_equal user.username, username
  end

  def test_create_user_with_friends
    username = "username"
    friends = [{username: "f1"},{username: "f2"}]

    user = Fakebook::User.new(username, friends)

    assert_equal user.friends.size, 2
    assert_equal user.friends.first.username, "f1"
  end
end
