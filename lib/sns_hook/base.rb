# lib/base.rb

module SNSHook
  class Base
    DEFAULT_MACHINE = SNSHook::Machines::Aws
    AVAILABLE_MACHINES = {
      aws: DEFAULT_MACHINE,
      kafka: SNSHook::Machines::Kafka
    }.freeze

    def client
      _client
    end

    private

    def _client
      @_client ||= machine.new
    end

    def machine
      @machine ||= AVAILABLE_MACHINES[SNSHook.config.machine.to_sym] ||
                   DEFAULT_MACHINE
    end
  end
end
