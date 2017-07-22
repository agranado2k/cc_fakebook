module Fakebook
  module Core
    class Payment
      attr_accessor :value, :recipient, :external_payment_id, :external_recipient_id

      def initialize(args)
        @value = args[:value]
        @recipient = args[:recipient]
        @external_payment_id = args[:external_payment_id]
        @external_recipient_id = args[:external_recipient_id]
      end
    end
  end
end
