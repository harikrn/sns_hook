# frozen_string_literal: true

require_relative 'lib/sns_hook/version'

Gem::Specification.new do |s|
  s.name        = 'sns_hook'
  s.version     = SNSHook.version
  s.licenses    = ['MIT']
  s.summary     = 'This is a sinatra app for hooking with sns'
  s.description = 'This app listens to AWS SNS'
  s.authors     = %w[Harikrishnan\n Namboothiri]
  s.email       = 'harikrishnan.nambbothiri@eventinc.de'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'https://rubygems.org/gems/example'
  s.metadata    = { 'source_code_uri' => 'https://github.com/harikrn/sns_hooks',
                    'rubygems_mfa_required' => 'true' }
  s.required_ruby_version = '>= 2.6.2'

  s.add_dependency 'aws-sdk-sns', '~> 1.53.0'
  s.add_dependency 'pstore', '~> 0.1.1'
  s.add_dependency 'sinatra', '~> 2.2.0'
  s.add_dependency 'thin', '~> 1.8.1'
  s.add_dependency 'zeitwerk', '~> 2.4.0'

  s.add_development_dependency 'pry', '~> 0.14.1'
  s.add_development_dependency 'rubocop', '~> 1.26.0'
end
