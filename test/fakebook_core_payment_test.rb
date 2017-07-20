require "test_helper"

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

class PaymentTest < Minitest::Test
  def test_create_payment
    value = 10
    recipient = Fakebook::Core::User.new("userB")

    payment = Fakebook::Core::Payment.new(value, recipient)

    assert_equal payment.recipient, recipient
    assert_equal payment.value, 10
  end
end
