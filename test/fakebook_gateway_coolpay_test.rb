require "test_helper"
require "fakebook_gateway_api_gateway_interface_test"

class CoolPayTest < Minitest::Test
  include ::APIGatewateyInterfaceTest

  def setup
    @cool_pay = @object = Fakebook::Gateway::CoolPay.new
  end

  def test_symbolize_keys_with_nested_hash
    json = {"a" => {"b" => "c"}}

    result = @cool_pay.symbolize_keys(json)

    assert_equal result, {a: {b: "c"}}
  end

  def test_symbolize_keys_with_array
    json = {"a" => [{"b" => "c"}]}

    result = @cool_pay.symbolize_keys(json)

    assert_equal result, {a: [{b: "c"}]}
  end

  def test_get_auth_token_from_login
    username = "arthur"
    apikey = "68830AEF4DBFAD18"
    response = nil

    VCR.use_cassette("test_get_auth_token_from_login") do
      response = @cool_pay.login(username, apikey)
    end

    refute_nil response[:token]
  end

  def test_get_recipient_by_name_with_success
    username = "get_api_test"
    response = nil

    VCR.use_cassette("test_get_recipient_by_name_with_success") do
      response = @cool_pay.get_recipient(username)
    end

    refute_nil response[:success]
    refute_nil response[:success][:external_recipient_id]
    assert_equal "get_api_test", response[:success][:recipient_name]
  end

  def test_get_recipient_by_name_with_fail
    username = "unknown_name"

    assert_raises Fakebook::Gateway::RecipientNotFound do
      VCR.use_cassette("test_get_recipient_by_name_with_fail") do
        @cool_pay.get_recipient(username)
      end
    end
  end

  def test_create_recipient_with_success
    username = "some_name-#{SecureRandom.hex}"
    response = nil

    VCR.use_cassette("test_create_recipient_with_success") do
      response = @cool_pay.create_recipient(username)
    end

    refute_nil response[:success]
    refute_nil response[:success][:external_recipient_id]
    refute_nil username, response[:success][:recipient_name]
  end

  def test_create_payment_with_success
    #username = "user_b"
    #value = 12.56
    #recipeint_id = ?

    #response = @cool_pay.create_payment(value, recipeint_id)

    #assert_equal 12.56, response[:success][:value]
    #assert_equal "user_b", response[:success][:recipient]
    #refute_nil response[:success][:external_payment_id]
    #refute_nil response[:success][:external_recipient_id]
  end
end
