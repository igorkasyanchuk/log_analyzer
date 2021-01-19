[![Build Status](https://travis-ci.org/igorkasyanchuk/log_analyzer.svg?branch=master)](https://travis-ci.org/igorkasyanchuk/log_analyzer)
[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)

# LogAnalyzer

See how fast is rendering in your Ruby on Rails app. Based on information from logs. Provides you a picture of how often renders and how fast renders your views.

## Sample

[![Sample](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/screenshot.png)](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/screenshot.png)

[![Reports](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/reports.png)](https://raw.githubusercontent.com/igorkasyanchuk/log_analyzer/master/docs/reports.png)

You can see columns:

* Type - type of file (partial or view = P or V)
* View - name of view
* Count - number of renders
* Avg - average time of rendering (in milliseconds)
* Max - maximum time of rendering
* Min - minimum time of rendering

## Installation

Could be installed as standalone (without adding to Gemfile).

Add this line to your application's Gemfile:

```ruby
gem 'log_analyzer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_analyzer

## Usage

After installation run in console command `log_analyzer -f log/development.log`. You can change the file or sorting (time, count, name).

Samples:

* `log_analyzer log/development.log -s count`
* `log_analyzer log/production.log`
* `log_analyzer production.log -csv`
* `log_analyzer production.log -pdf`
* `log_analyzer -f log/production.log -s name`
* `log_analyzer -f log/production.log -s time -f v`
* `log_analyzer -f log/production.log -s rtime -f v`
* `log_analyzer -file log/production.log -sort count`
* `log_analyzer -file log/production.log -sort count -filter view`
* `log_analyzer -file log/production.log -sort count -filter partial`
* `log_analyzer -file log/production.log -sort time -filter p`
* `log_analyzer development.log -csv -s time -f p`
* `log_analyzer development.log -xls -s time -f p`
* `log_analyzer log/production.log -pdf --short`
* `log_analyzer -file log/production.log --short`
* `log_analyzer --help`

**Based on results you can get an idea what to optimize. For example optimizing most often rendering view could give huge benefit. Now with this tool you can find out what are the numbers.**

Based on the observations I suggest to run this tool for files less than 1Gb. If you have enough RAM - download the log file to local machine and then run the tool.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem on your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igorkasyanchuk/log_analyzer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Contributors

Big thank you to all our contributors:

* [@ck3g](https://github.com/ck3g)
* [@ritaritual](https://github.com/ritaritual)
* [@y-yagi](https://github.com/y-yagi)
* [@RafaelHashimoto](https://github.com/RafaelHashimoto)
* [@Quentinchampenois](https://github.com/Quentinchampenois)

## TODO

* more analytics
* more specs
* export to XLS
* export to HTML/CSS/JS with datatable.js

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/)

