# frozen_string_literal: true

require 'pry'

module SNSHook
  # server to receive response from SNS
  class Server < Sinatra::Base
    before do
      merge_params
    end

    get '/' do
      response.body = 'Hello World'
    end

    get '/sns' do
      puts params

      response.status = 200
      response.body = { message: :ok }.to_json
    end

    post '/sns' do
      puts params

      response.status = 200
      response.body = { message: :ok }.to_json
    end

    private

    def merge_params
      body_params = request.body.read
      return if body_params.empty?

      params.merge!(JSON.parse(body_params))
    end
  end
end
