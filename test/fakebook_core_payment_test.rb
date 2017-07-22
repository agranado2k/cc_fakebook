require "test_helper"

class PaymentTest < Minitest::Test
  def setup
    @db_dump = Fakebook::Core::DBDump.new
  end

  def test_create_payment
    payment = Fakebook::Core::Payment.new({value: 10, recipient: "userB"})

    assert_equal payment.recipient, "userB"
    assert_equal payment.value, 10
    assert_nil payment.external_payment_id
    assert_nil payment.external_recipient_id
  end
end
