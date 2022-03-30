# frozen_string_literal: true

module SNSHook
  module Routes
    # Topics root
    module Topics
      Server.get '/sns/topics' do
        erb :topics, locals: { topics: SNSHook.connection.topics }
      end

      Server.post '/sns/topics' do
        SNSHook.connection.new_topic(params.dig(:topic, :name))

        flash[:success] = 'Created a new topic'
        redirect to('/sns/topics')
      end

      Server.delete '/sns/topics' do
        SNSHook.connection.delete_topic(params[:arn])
        SNSHook.connection.reset
        SNSHook.repo.clear

        flash[:success] = 'Deleted topic'
        redirect to('/sns/topics')
      end
    end
  end
end
