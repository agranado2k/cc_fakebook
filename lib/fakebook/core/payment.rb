module Fakebook
  module Core
    class Payment
      attr_accessor :value, :recipient

      def initialize(value, recipient)
        @value = value
        @recipient = recipient
      end
    end
  end
end
