module Fakebook
  module Core
    class Payment
      attr_accessor :value, :recipient

      def initialize(args)
        @value = args[:value]
        @recipient = args[:recipient]
      end
    end
  end
end
