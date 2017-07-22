module Fakebook
  module Core
    class DBDump
      @@users = {}

      def initialize
        @@users = {}
      end

      def add_payment(user,payment)
        if @@users[user.username].nil?
          @@users[user.username] = {payments: []}
        end
        @@users[user.username][:payments].push(payment)
      end

      def payments(user)
        @@users[user.username].nil? ? [] : @@users[user.username][:payments]
      end
    end
  end
end
