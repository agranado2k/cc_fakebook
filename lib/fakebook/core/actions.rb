module Fakebook
  module Core
    class Actions
      def send_money(user_b, value, api)
        external_recipient_id = get_recipient_id(user_b.username,api)
        api_response = api.create_payment(value, external_recipient_id, user_b.username)
        create_payment_params(value, user_b, api_response)
      end

      def get_recipient_id(name, api)
        recipient_api_response = api.get_or_create_recipient(name)
        recipient_api_response[:success][:external_recipient_id]
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
        api.list_payments
      end
    end
  end
end
