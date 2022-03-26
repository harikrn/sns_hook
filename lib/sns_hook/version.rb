# frozen_string_literal: true

module SNSHook
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  def self.version
    gem_version
  end

  module VERSION
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    PRE   = 'alpha'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
