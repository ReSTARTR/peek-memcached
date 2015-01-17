require 'peek-memcached'
require 'minitest/autorun'

class MemcachedTest < MiniTest::Unit::TestCase
  def setup
    Memcached.init_peek_stats
    @memcached = Memcached.new
    @memcached.flush
  end

  def test_get_and_miss
    assert_raises(::Memcached::NotFound) do
      @memcached.get('foo')
    end
  ensure
    assert_equal 1, Memcached.calls.value
    assert_equal 0, Memcached.get_hits.value
    assert_equal 1, Memcached.get_misses.value
    assert_equal 0, Memcached.sets.value
  end

  def test_get_and_hit
    @memcached.set('foo', 99)
    result = @memcached.get('foo')
    assert_equal 99, result
  rescue ::Memcached::NotFound
    assert_equal 1, Memcached.calls.value
    assert_equal 1, Memcached.get_hits.value
    assert_equal 0, Memcached.get_misses.value
    assert_equal 1, Memcached.sets.value
  end
end
