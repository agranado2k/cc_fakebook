module Fakebook
  module Gateway
    class CoolPay
      def create_payment

      end

      def get_or_create_recipient(name)
        response = get_recipient(name)

        response
      end

      def get_recipient(name)
        token = login("arthur", "68830AEF4DBFAD18")[:token]
        url = "https://coolpay.herokuapp.com/api/recipients?name=#{name}"
        response = RestClient.get(url, headers={"Content-Type" => "application/json",
                                     Authorization: "Bearer #{token}"})
        create_recipient_response(parse_response(response))
      end

      def create_recipient_response(body)
        {success: {
          recipient_name: body[:recipients][:name],
          external_recipient_id: body[:recipients][:id]
        }}
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
                          v.reduce([]){|result, v| symbolize_keys(v)}
                        else
                         v
                        end
          h
        end
      end
    end
  end
end
