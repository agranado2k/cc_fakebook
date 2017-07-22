module Fakebook
  module Core
    class Actions
      def send_money(user_a, user_b, value, api)
        api_response = api.create_payment(user_b.username, value)
        api_payment_id = api_response[:success][:external_payment_id]
        api_recipient_id = api_response[:success][:external_recipient_id]
        payment_args = {value: value,
                        recipient: user_b.username,
                        external_payment_id: api_payment_id,
                        external_recipient_id: api_recipient_id}
        payment = Payment.new(payment_args)
        user_a.add_payment(payment)
        user_a
      end
    end
  end
end
