# frozen_string_literal: true

module SNSHook
  module Routes
    # Topics root
    module Subscriptions
      Server.get '/sns/subscriptions' do
        erb :subscriptions, locals: { subscriptions: SNSHook.connection.subscriptions }
      end

      Server.post '/sns/subscriptions' do
        SNSHook.connection.subscribe(params.dig(:subscribe, :topic))

        flash[:success] = 'Created subscription'
        redirect to('/sns/subscriptions')
      end

      Server.delete '/sns/subscriptions' do
        SNSHook.connection.unsubscribe(params[:arn])

        flash[:success] = 'Successfully unsubscribed'
        redirect to('/sns/subscriptions')
      end
    end
  end
end
