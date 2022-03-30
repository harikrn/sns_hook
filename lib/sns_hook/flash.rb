# frozen_string_literal: true

module SNSHook
  # Flash message storage
  class Flash < DelegateClass(Hash)
    attr_reader :now, :next

    def initialize(cookie)
      @now = cookie || {}
      @now.transform_keys!(&:to_sym)
      @next = {}
      super(@now)
    end

    def []=(key, value)
      self.next[key.to_sym] = value
    end

    def sweep
      @now.replace(@next)
      @next = {}
      @now
    end
  end
end
