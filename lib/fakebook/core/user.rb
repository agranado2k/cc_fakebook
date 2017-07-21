module Fakebook
  module Core
    class User
      attr_accessor :username, :friends

      def initialize(args=nil)
        @username = args[:username]
        @friends = create_friend_list(args[:friends])
      end

      def create_friend_list(friends)
        friends.nil? ? [] : friends.reduce([]){|l, f| l.push(User.new(f))}
      end
    end
  end
end
