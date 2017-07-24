module Fakebook
  module Core
    class User
      attr_accessor :username, :credentials

      def initialize(args)
        @username = args[:username]
        @credentials = args[:credentials]
      end
    end
  end
end
