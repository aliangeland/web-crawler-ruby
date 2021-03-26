# Crawler

A simple web crawler written in Ruby

## Installation (using docker *RECOMMENDED)

Navigate to project's root then execute:

    $ docker-compose build

And then:

    $ docker-compose up -d

Note: you should already have installed docker on your system

Note: for removing containers you can execute:

    $ docker-compose down -v

Note: to see crawled products, you could check recently added .db file to your project's root folder after running containers. also you can check docker's console too.   

## Installation (as a gem)

Add this line to your application's Gemfile:

bundle install

```ruby
gem 'crawler'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install crawler

## Usage

Crawler gem can be used as a crawler for your website (code should be tailored to your taste)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/web-crawler-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
