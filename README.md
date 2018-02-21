# LogAnalyzer

See how fast is rendering in your Ruby on Rails app. Based on information from logs.

## Sample

[![Sample](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/log_analyzer_small.png)](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/log_analyzer_small.png)

You can see columns:

* View - name of view
* Count - number of renders
* Avg - average time of rendering
* Max - maximum number of rendering
* Min - minimum number of rendering


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_analyzer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_analyzer

## Usage

After instalation run in console command `log_analyzer -f log/development.log`. You can change the file or sorting (time, count, name).
Samples:

* `log_analyzer log/development.log -s count`
* `log_analyzer log/production.log`
* `log_analyzer -f log/production.log -s name`
* `log_analyzer -f log/production.log -s time`
* `log_analyzer -file log/production.log -sort count`

**Based on results you can get an idea what to optimize. For example optimizing most often rendering view could give huge benefit. Now with this tool you can find out what are the numbers.**

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/varyform/log_analyzer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

