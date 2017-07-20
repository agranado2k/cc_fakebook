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
