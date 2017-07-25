module APIGatewateyInterfaceTest
  def test_implement_api_gateway_interface
    assert_respond_to @object, :create_payment
    assert_respond_to @object, :list_payments
    assert_respond_to @object, :get_or_create_recipient
  end
end
