require "sinatra"
require_relative "../lib/fakebook"

get "/" do
  @current_user = Fakebook::Core::User.new({username: "User A", credentials: {username: "arthur", apikey: "68830AEF4DBFAD18"}})
  cool_pay = Fakebook::Gateway::CoolPay.new(@current_user.credentials)
  @payments = cool_pay.list_payments

  erb :index
end
