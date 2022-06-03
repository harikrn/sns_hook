# frozen_string_literal: true

module SNSHook
  # Connection
  class Connection < Base
    def respond_to_missing?(method)
      client.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      if client.respond_to?(method)
        if block_given?
          client.send(method, *args, &block)
        else
          client.send(method, *args)
        end
      else
        super
      end
    end
  end
end
