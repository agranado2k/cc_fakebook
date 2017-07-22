module Fakebook
  module Core
    class Actions
      def send_money(user_a, user_b, value, api)
        user_a.add_payment(Payment.new(create_payment_params(value, user_b, api.create_payment(user_b.username, value))))
        user_a
      end

      def create_payment_params(value, user, api_response)
        {
          value: value,
          recipient: user.username,
          external_payment_id: api_response[:success][:external_payment_id],
          external_recipient_id: api_response[:success][:external_recipient_id]
        }
      end

      def list_payments(user, api)
        api_response = api.list_payments(user.username)
        api_response[:success].reduce([]) do |result, external_payment|
          result << Payment.new(external_payment)
        end
      end
    end
  end
end
