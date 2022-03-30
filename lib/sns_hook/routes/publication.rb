# frozen_string_literal: true

module SNSHook
  module Routes
    # Publication
    module Publication
      Server.get '/sns/publications' do
        content_type :json

        SNSHook.repo.to_json
      end

      Server.post '/sns/publications' do
        SNSHook.connection.publish(
          params.dig(:publish, :message),
          params.dig(:publish, :topic)
        )

        flash[:success] = 'Published your message'
        redirect to('/sns')
      rescue Aws::SNS::Errors::InvalidParameter => e
        flash[:error] = e.message
        redirect to('/sns')
      end
    end
  end
end
