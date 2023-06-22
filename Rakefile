require 'bundler/setup'
$LOAD_PATH.unshift File.expand_path('lib', __dir__)

# rake spec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) { |t| t.verbose = false }

def unsubscribe
  puts 'Unsubscribed'
  SNSHook.connection.unsubscribe
  exit!
end

# rake console
task :console do
  require 'pry'
  require 'sns_hook'
  ARGV.clear
  Pry.start
end

namespace :app do
  task :listener do
    require 'sns_hook'
    require 'json'
    require 'pry'
    require_relative "#{__dir__}/config/init.rb"

    SNSHook.connection.topics.each do |topic|
      SNSHook.connection.subscribe(topic)
    end

    trap('TERM') { unsubscribe }
    trap('INT') { unsubscribe }

    puts 'Listening...'
    SNSHook.connection.listen do |message|
      puts message.key, message.value
      notification =
        begin
          JSON.parse(message.value)
        rescue JSON::ParserError
          message.value
        end
      SNSHook.repo.push(notification)
    end
  end
end
