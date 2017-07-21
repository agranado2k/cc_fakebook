require "test_helper"

class PaymentTest < Minitest::Test
  def test_create_payment
    value = 10
    recipient = Fakebook::Core::User.new({username: "userB"})

    payment = Fakebook::Core::Payment.new(value, recipient)

    assert_equal payment.recipient, recipient
    assert_equal payment.value, 10
  end
end
