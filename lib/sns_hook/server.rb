# frozen_string_literal: true

require 'pry'

module SNSHook
  # server to receive response from SNS
  class Server < Sinatra::Base
    configure :production, :development do
      enable :logging
    end

    helpers Helpers::UrlHelper, Helpers::FlashHelper

    before do
      merge_params
    end

    include Routes::Topics
    include Routes::Subscriptions
    include Routes::Publication

    after do
      @flash&.each { |key, _flash| response.set_cookie(key, @flash[key].next.to_json) }
    end

    get '/' do
      redirect to('/sns')
    end

    get '/sns' do
      data = SNSHook.repo.read

      erb :sns_list, locals: { data: data }
    end

    post '/sns' do
      SNSHook.repo.push(params)

      if params['Type'] == 'SubscriptionConfirmation'
        SNSHook.connection.confirm_subscription(params['TopicArn'], params['Token'])
      end

      response.status = 200
      response.body = { message: :ok }.to_json
    end

    private

    def merge_params
      body_params = request.body.read
      return if body_params.empty?

      params.merge!(JSON.parse(body_params))
    rescue JSON::ParserError
      params[:data] = body_params
    end
  end
end
