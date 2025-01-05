# Angie

A DSL for generating configuration files for the web server [Angie](https://angie.software/) (formerly known as Nginx)

## Installation

```
gem install angie
```

## Usage

```ruby
config = Angie::DSL.new do
  worker_processes 4

  events do
    worker_connections 1024
  end

  http do
    server do
      listen 80
      server_name "example.com"

      location "/" do
        root "/var/www/html"
        index "index.html"
      end

      location "/images/" do
        root "/var/www/images"
      end
    end
  end
end

puts config.to_s
```

```nginx
worker_processes 4;
events {
  worker_connections 1024;
}
http {
  server {
    listen 80;
    server_name example.com;
    location {
      root /var/www/html;
      index index.html;
    }
    location {
      root /var/www/images;
    }
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creadone/angie.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
