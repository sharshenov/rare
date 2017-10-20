# frozen_string_literal: true

module Rare
  class Throttler
    def initialize
      @mutex = Mutex.new
    end

    def throttle(rpm:, key: 'default')
      if rpm.to_f > 0
        sleep sleep_interval until allowed?(seconds(rpm), key)
      end

      yield if block_given?
    end

    private

    def seconds(rpm)
      60.0 / rpm
    end

    def allowed?(seconds, key)
      @mutex.synchronize do
        now       = Time.now.to_f
        timestamp = get(key)

        if timestamp.nil? || timestamp < now - seconds
          set(key, now)
          return true
        end

        false
      end
    end

    def get(key)
      value = storage[key]

      return value.to_f if value && !value.is_a?(Float)

      value
    end

    def set(key, value)
      storage[key] = value
    end

    def storage
      Rare.configuration.storage
    end

    def sleep_interval
      Rare.configuration.sleep_interval
    end
  end
end
