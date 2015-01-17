# Peek::Memcached

Take a peek into the Memcache commands made through Memcached during your application's requests.

Thins this peek view provides:

 * Total number of memcache commands called during the request
 * The number of memcache `get` and hit commands called during the request
 * The number of memcache `get` and miss commands called during the request
 * The number of memcache `set` commands called during the request
 * The duration of the commands made during the request

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'peek-memcached'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install peek-memcached

## Usage

Add the following to your `config/initializers/peekrb`:

```ruby
Peek.into Peek ::Views::Memcached
```

There is an additional JavaScript file peek-memcached provides that gives additional infomation about the requests Memcached makes during the request:

 * Get[HIT]
 * Get[MISS]
 * Set

Include the `peek/views/memcachced` JavaScript file in your application:

```coffee
#= require peek
#= require peek/views/memcached
```

## Contributing

1. Fork it ( https://github.com/ReSTARTR/peek-memcached/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
