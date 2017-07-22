module Fakebook
  module Core
    class User
      attr_accessor :username, :friends, :mapper

      def initialize(args, mapper)
        @username = args[:username]
        @friends = create_friend_list(args[:friends])
        @payments = args[:payments] || []
        @mapper = mapper
      end

      def create_friend_list(friends)
        friends.nil? ? [] : friends.reduce([]){|l, f| l.push(User.new(f, mapper))}
      end

      def add_payment(payment)
        mapper.add_payment(self, payment)
      end

      def payments
        mapper.payments(self)
      end
    end
  end
end
