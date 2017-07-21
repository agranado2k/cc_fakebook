module Fakebook
  module Core
    class User
      attr_accessor :username, :friends, :payments

      def initialize(args=nil)
        @username = args[:username]
        @friends = create_friend_list(args[:friends])
        @payments = args[:payments] || []
      end

      def create_friend_list(friends)
        friends.nil? ? [] : friends.reduce([]){|l, f| l.push(User.new(f))}
      end

      def add_payment(payment)
        @payments.push(payment)
      end
    end
  end
end
