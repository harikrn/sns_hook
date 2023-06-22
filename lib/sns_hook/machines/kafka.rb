# lib/kafka.rb

require 'kafka'

module SNSHook
  module Machines
    class Kafka
      GROUP_ID = 'sns-hook-consumer'.freeze
      SYSTEM_TOPICS = ['__consumer_offsets'].freeze

      class << self
        def client
          @client ||= ::Kafka.new(ENV.fetch('KAFKA_HOST', 'localhost:9092'), client_id: 'sns_hook')
        end
      end

      def initialize(*_args)
        trap('TERM') { consumer.stop }
      end

      def new_topic(topic_name)
        client.create_topic(
          topic_name,
          num_partitions: 3
        )
      end

      def topics
        client.topics.reject { |topic| SYSTEM_TOPICS.include?(topic) }
      end

      def delete_topic(topic_name)
        client.delete_topic(topic_name.to_s)
      end

      def subscribe(topic)
        consumer.subscribe(topic, start_from_beginning: false)
      end

      def subscriptions(*_args)
        topics
      end

      def publish(message, topic)
        producer.produce(message, topic: topic)
        producer.deliver_messages
      end

      def listen(*_args, &block)
        consumer.each_message(&block)
      end

      def unsubscribe(*_args)
        consumer.stop
        @topics = []
      end

      def confirm_subscription(*_args)
        true
      end

      def reset
        @subscriptions = nil
        @topics = nil
      end

      private

      def client
        self.class.client
      end

      def producer
        @producer ||= client.async_producer(
          delivery_threshold: 100,
          delivery_interval: 30
        )
      end

      def consumer
        @consumer ||= client.consumer(group_id: GROUP_ID)
      end
    end
  end
end
