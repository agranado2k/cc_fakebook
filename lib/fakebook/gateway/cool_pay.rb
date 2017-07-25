module Fakebook
  module Gateway

    class RecipientNotFound < RuntimeError
    end

    class CoolPay
      BASE_URL = "https://coolpay.herokuapp.com/api"

      attr_reader :username, :apikey

      def initialize(credentials)
        @username = credentials[:username]
        @apikey = credentials[:apikey]
      end

      def create_payment(value, recipient_id, recipient_name)
        url = "#{BASE_URL}/payments"
        body = {payment: {amount: value, currency: "GBP", recipient_id: recipient_id}}.to_json
        response = RestClient.post(url, body, headers)
        body = parse_response(response.body)
        create_payment_response(body, recipient_name)
      end

      def create_payment_response(body, recipient_name)
        {
          success: {
            value: body[:payment][:amount],
            recipient: recipient_name,
            external_payment_id: body[:payment][:id],
            external_recipient_id: body[:payment][:recipient_id]
          }
        }
      end

      def list_payments
        url = "#{BASE_URL}/payments"
        response = RestClient.get(url, headers)
        body = parse_response(response.body)
        recipients =  list_recipients
        body[:payments].map do |p|
          rs = get_recipient_by_id(p[:recipient_id], recipients)
          p[:recipient] = rs[:name]
          p
        end
      end

      def get_or_create_recipient(name)
        response = get_recipient(name)
      rescue RecipientNotFound
        response = create_recipient(name)
      ensure
        response
      end

      def get_recipient(name)
        url = "#{BASE_URL}/recipients?name=#{name}"
        response = RestClient.get(url, headers)
        body = parse_response(response.body)
        fail RecipientNotFound if body[:recipients].empty?
        create_recipient_response(select_recipeint_by_name(body, name))
      end

      def get_recipient_by_id(id, recipients)
        recipients.select{|r| r[:id] == id}.first
      end

      def list_recipients
        url = "#{BASE_URL}/recipients"
        response = RestClient.get(url, headers)
        body = parse_response(response.body)
        body[:recipients]
      end

      def create_recipient(name)
        url = "#{BASE_URL}/recipients"
        body = {recipient: {name: name}}.to_json
        response = RestClient.post(url, body, headers)
        body = parse_response(response.body)
        create_recipient_response(body[:recipient])
      end

      def create_recipient_response(body)
        {success: {
          recipient_name: body[:name],
          external_recipient_id: body[:id]
        }}
      end

      def select_recipeint_by_name(response, name)
        response[:recipients].select{|r| r[:name] == name}.first
      end

      def headers
        base_headers.merge({Authorization: "Bearer #{token}"})
      end

      def token
        login(username, apikey)[:token]
      end

      def login(username, apikey)
        url = "#{BASE_URL}/login"
        body = {username: username, apikey: apikey}.to_json
        response = RestClient.post(url, body, base_headers)
        parse_response(response.body)
      end

      def base_headers
        {content_type: :json, accept: :json}
      end

      def parse_response(body)
        JSON.parse(body).symbolize_keys
      end
    end
  end
end
