#!/usr/bin/env ruby

SNSHook.configure do |config|
  config.machine = ENV.fetch('SNS_MACHINE', 'aws')
end
