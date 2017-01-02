# Simple rate limiter

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rare'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rare

## Usage

Basic usage

```ruby
Rare.throttle rpm: 60 do
  #do_request_to_api
end
```

Using keys

```ruby
threads = []

threads << Thread.new do
  Rare.throttle rpm: 60, key: 'API1' do
    #do_request_to_api_1
  end
end

threads << Thread.new do
  Rare.throttle rpm: 60, key: 'API2' do
    #do_request_to_api_2
  end
end

threads.each(&:join)
```

## Configuration

```ruby
Rare.configure do |config|
  config.storage = Redis.current # default is Hash.new
  config.sleep_interval = 1 # default is 0.01
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sharshenov/rare.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

