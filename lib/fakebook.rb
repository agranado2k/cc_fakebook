require "rest-client"

class Hash
  def symbolize_keys
    self.reduce({}) do |h, (k,v)|
      h[k.to_sym] = if v.is_a?(Hash)
                      v.symbolize_keys
                    elsif v.is_a?(Array)
                      v.reduce([]){|result, v| result << v.symbolize_keys}
                    else
                     v
                    end
      h
    end
  end
end
require_relative "./fakebook/core/user"
require_relative "./fakebook/core/actions"
require_relative "./fakebook/gateway/cool_pay"
