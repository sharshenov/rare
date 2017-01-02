# frozen_string_literal: true

module Rare
  class Configuration
    attr_accessor :storage,
                  :sleep_interval

    def initialize
      @storage        = {}
      @sleep_interval = 0.01
    end
  end
end
