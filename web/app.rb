require "sinatra"
require_relative "../lib/fakebook"

get "/" do
  @current_user = Fakebook::Core::User.new({username: "User A", credentials: {username: "arthur", apikey: "68830AEF4DBFAD18"}})
  cool_pay = Fakebook::Gateway::CoolPay.new(@current_user.credentials)
  @payments = cool_pay.list_payments

  erb :index
end

post "/send_money" do
  recipient_name = params["name"].gsub(/\s/,"_")
  value = params["amount"]
  @current_user = Fakebook::Core::User.new({username: "User A", credentials: {username: "arthur", apikey: "68830AEF4DBFAD18"}})
  cool_pay = Fakebook::Gateway::CoolPay.new(@current_user.credentials)

  api_response = cool_pay.get_or_create_recipient(recipient_name)
  response = "{}"

  if api_response[:success]
    recipient_id = api_response[:success][:external_recipient_id]
    payment = cool_pay.create_payment(value, recipient_id, recipient_name)
    response = 400 unless payment[:success]
  else
    response = 400
  end

  content_type :json
  response
end
