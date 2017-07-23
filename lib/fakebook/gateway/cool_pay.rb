module Fakebook
  module Gateway

    class RecipientNotFound < RuntimeError
    end

    class CoolPay
      def create_payment

      end

      def get_or_create_recipient(name)
        response = get_recipient(name)
      rescue RecipientNotFound
        response = create_recipient(name)
      ensure
        response
      end

      def get_recipient(name)
        token = login("arthur", "68830AEF4DBFAD18")[:token]
        url = "https://coolpay.herokuapp.com/api/recipients?name=#{name}"
        headers =  {content_type: :json, accept: :json, Authorization: "Bearer #{token}"}
        response = RestClient.get(url, headers)
        body = parse_response(response.body)
        fail RecipientNotFound if body[:recipients].empty?
        create_recipient_response(select_recipeint_by_name(body, name))
      end

      def create_recipient(name)
        token = login("arthur", "68830AEF4DBFAD18")[:token]
        url = "https://coolpay.herokuapp.com/api/recipients"
        body = {recipient: {name: name}}
        headers =  {content_type: :json, accept: :json, Authorization: "Bearer #{token}"}
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

      def list_payments

      end

      def login(username, apikey)
        url = "https://coolpay.herokuapp.com/api/login"
        body = {username: username, apikey: apikey}.to_json
        headers =  {content_type: :json, accept: :json}
        response = RestClient.post(url, body, headers)
        parse_response(response.body)
      end

      def parse_response(body)
        symbolize_keys(JSON.parse(body))
      end

      def symbolize_keys(hash)
        hash.reduce({}) do |h, (k,v)|
          h[k.to_sym] = if v.is_a?(Hash)
                          symbolize_keys(v)
                        elsif v.is_a?(Array)
                          v.reduce([]){|result, v| result << symbolize_keys(v)}
                        else
                         v
                        end
          h
        end
      end
    end
  end
end
