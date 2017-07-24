require "test_helper"
require "fakebook/gateway/api_gateway_interface_test"

class APIGatewayDouble
  def get_or_create_recipient(name)
    {success: {
      recipient_name: "user_b",
      external_recipient_id: "external_recipient_id"
    }}
  end

  def create_payment(value, recipient_id, recipient_name)
    {success: {
      external_payment_id: "external_payment_id",
      external_recipient_id: "external_recipient_id"
    }}
  end

  def list_payments
    [
      {recipient: "user_b", value: 12.34, external_payment_id: "pa1", external_recipient_id: "rb1"},
      {recipient: "user_c", value: 2.44, external_payment_id: "pa4", external_recipient_id: "rc1"}
    ]
  end
end

class ActionTest < Minitest::Test
  include ::APIGatewateyInterfaceTest

  def setup
    @api_gateway = @object = APIGatewayDouble.new
  end

  def test_action_send_money_between_users
    value = 11.45
    user_b = Fakebook::Core::User.new({username: "user_b"})

    payment = Fakebook::Core::Actions.new.send_money(user_b, value, @api_gateway)

    assert_equal payment[:recipient], user_b.username
    assert_equal payment[:value], value
    assert_equal payment[:external_recipient_id], "external_recipient_id"
    assert_equal payment[:external_payment_id], "external_payment_id"
  end

  def test_action_list_payments_by_user
    user_a = Fakebook::Core::User.new({username: "user_a"})

    payments = Fakebook::Core::Actions.new.list_payments(user_a, @api_gateway)

    assert_equal payments.size, 2
  end
end
