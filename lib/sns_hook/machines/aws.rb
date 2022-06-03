# lib/aws.rb

require 'aws-sdk-sns'

module SNSHook
  module Machines
    class Aws
      attr_reader :client

      def initialize
        @client = ::Aws::SNS::Client.new
      end

      def new_topic(topic_name)
        client.create_topic(name: topic_name)
        @topics = nil
      end

      def topics
        @topics ||= client.list_topics.topics.map(&:topic_arn)
      end

      def delete_topic(topic_arn)
        client.delete_topic(topic_arn: topic_arn)
      end

      def subscriptions(limit: -1)
        return @subscriptions if @subscriptions

        resp = client.list_subscriptions
        @subscriptions = resp.subscriptions.map(&:subscription_arn)
        return @subscriptions if @subscriptions.count >= limit && !limit.negative?

        while resp.next_page?
          resp = resp.next_page
          @subscriptions += resp.subscriptions.map(&:subscription_arn)
        end
        @subscriptions
      end

      def publish(message, topic_arn)
        client.publish(
          topic_arn: topic_arn,
          message: message
        )
      end

      def subscribe(topic_arn)
        client.subscribe(
          topic_arn: topic_arn,
          protocol: 'http',
          endpoint: "#{ENV.fetch("AWS_SNS_HOST", "")}/sns"
        )
      end

      def unsubscribe(subscription_arn)
        client.unsubscribe(subscription_arn: subscription_arn)
        @subscriptions = nil
        @topics = nil
        true
      end

      def confirm_subscription(topic_arn, token)
        client.confirm_subscription(
          topic_arn: topic_arn,
          token: token
        )
        @subscriptions = nil
      end

      def reset
        @subscriptions = nil
        @topics = nil
      end
    end
  end
end
