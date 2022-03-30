# frozen_string_literal: true

require 'zeitwerk'
require 'sinatra'
require 'aws-sdk-sns'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect('sns_hook' => 'SNSHook')
loader.enable_reloading
loader.setup

# SNSHook to listen to aws sns
module SNSHook
  def self.repo
    @repo ||= SNSHook::Repository.init
  end

  def self.connection
    @connection ||= SNSHook::Connection.new
  end
end
