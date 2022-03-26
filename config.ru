# frozen_string_literal: true

require_relative 'lib/sns_hook'

run Rack::URLMap.new('/' => SNSHook::Server)
