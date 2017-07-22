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
        r = parse_response(response)
        p "r: #{r}"
        r.select{|r| r[:recipients][:name] == name}.first
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
          h[k.to_sym] = (v.is_a?(Hash) ? symbolize_keys(v) : v)
          h
        end
      end
    end
  end
end
