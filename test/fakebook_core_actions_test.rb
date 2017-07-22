require "test_helper"

class APIGatewayDouble
  def create_payment(recipient, value)
    {success: {
      external_payment_id: "external_payment_id",
      external_recipient_id: "external_recipient_id"
    }}
  end
end

class APIGatewayTest < Minitest::Test
  def setup
    @object = APIGatewayDouble.new
  end

  def test_implement_api_gateway_interface
    assert_respond_to @object, :create_payment
  end
end

class ActionTest < Minitest::Test
  def setup
    @db_dump = Fakebook::Core::DBDump.new
    @coolpay = APIGatewayDouble.new
  end

  def test_action_send_money
    value = 11.45
    user_a = Fakebook::Core::User.new({username: "user_a"}, @db_dump)
    user_b = Fakebook::Core::User.new({username: "user_b"}, @db_dump)

    user_a = Fakebook::Core::Actions.new.send_money(user_a, user_b, value, @coolpay)

    assert_equal user_a.payments.size, 1
    assert_equal user_a.payments.first.recipient, user_b.username
    assert_equal user_a.payments.first.value, value
    assert_equal user_a.payments.first.external_recipient_id, "external_recipient_id"
    assert_equal user_a.payments.first.external_payment_id, "external_payment_id"
  end
end
