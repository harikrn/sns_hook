# frozen_string_literal: true

require 'pstore'

module SNSHook
  # Repository
  class Repository
    attr_reader :data

    class << self
      def init
        read || new
      end

      def read
        pstore.transaction(true) do
          pstore[:repo]
        end
      end

      def pstore
        @pstore ||= PStore.new('data/sns_notifications.pstore')
      end
    end

    def initialize(data = [])
      @data = data || []
    end

    def push(message)
      data.push(message)
      save
      message
    end

    def pop
      message = data.pop
      save
      message
    end

    def token
      token_data = data.find do |resp|
        next unless resp.respond_to?(:dig)

        resp['Type'] == 'SubscriptionConfirmation'
      end
      return unless token_data

      token_data['Token']
    end

    def read
      self.class.read&.data || []
    end

    def clear
      self.class.pstore.transaction do
        self.class.pstore[:repo] = nil
      end
    end

    def to_json(*_args)
      data.to_json
    end

    def save
      self.class.pstore.transaction do
        self.class.pstore[:repo] = self
      end
    end
  end
end
