require 'memcached'
require 'atomic'

Memcached.class_eval do
  class << self
    attr_accessor :duration, :calls, :get_hits, :get_misses, :sets

    def init_peek_stats
      self.duration = Atomic.new(0)
      self.calls = Atomic.new(0)
      self.get_hits = Atomic.new(0)
      self.get_misses = Atomic.new(0)
      self.sets = Atomic.new(0)
    end
  end
  self.init_peek_stats

  alias :get_orig :get

  def get(keys, decode=true)
    start = Time.now
    get_orig(keys, decode)
  rescue Memcached::NotFound => e
    hits = false
    raise e
  ensure
    _duration = Time.now - start
    self.class.duration.update { |v| v + _duration }
    self.class.calls.update { |v| v + 1 }
    if hits
      self.class.get_hits.update { |v| v + 1 }
    else
      self.class.get_misses.update { |v| v + 1 }
    end
  end

  alias :set_orig :set

  def set(key, value, ttl=@default_ttl, encode=true, flags=::Memcached::FLAGS)
    start = Time.now
    set_orig(key, value, ttl, encode, flags)
  ensure
    _duration = Time.now - start
    self.class.duration.update { |v| v + _duration }
    self.class.calls.update { |v| v + 1 }
    self.class.sets.update { |v| v + 1 }
  end
end

require 'peek/views/view'

module Peek
  module Views
    class Memcached < View
      def duration
        ::Memcached.duration.value
      end

      def formatted_duration
        ms = duration * 1000
        if ms >= 1000
          '%.2fms' % ms
        else
          '%.0fms' % ms
        end
      end

      def context
        {
          :get_hits => ::Memcached.get_hits.value,
          :get_misses => ::Memcached.get_misses.value,
          :sets => ::Memcached.sets.value,
        }
      end

      def results
        {
          :duration => formatted_duration,
          :calls => ::Memcached.calls.value,
        }
      end

      private

      def setup_subscribers
        before_request do
          ::Memcached.init_peek_stats
        end
      end
    end
  end
end
