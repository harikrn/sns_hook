# frozen_string_literal: true

require_relative 'lib/sns_hook'
require_relative 'config/init'

use Rack::MethodOverride
run Rack::URLMap.new('/' => SNSHook::Server)
