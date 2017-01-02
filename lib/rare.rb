# frozen_string_literal: true
require 'rare/throttler'
require 'rare/configuration'
require 'rare/version'

module Rare
  class << self
    def throttle(opts = {}, &block)
      throttler.throttle opts, &block
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    private

    def throttler
      @throttler ||= Throttler.new
    end
  end
end
