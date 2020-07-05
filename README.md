# RetailCalendars



## Installation

This gem implements 4-4-5 / 4-5-4 / 5-4-4 retail calendar in a very lightweight manner.
https://en.wikipedia.org/wiki/4%E2%80%934%E2%80%935_calendar

While several similar gems that do this exist (most notably the gem retail_calendar, not to be confused with this gem: retail_calendars), I couldn't find one that supports all forms 445, 454, 544 and that doesn't have serious issues and stale pull requests.

Credit due to Brian K https://stackoverflow.com/questions/23531481/is-there-a-way-in-ruby-to-find-the-beginning-of-the-year-in-a-4-5-4-retail-cal

The calendar starts on Sunday and ends on Saturday.

IMPORTANT: when installing, make sure you type the gem's name '**retail_calendars**' and not retail_calendar

```ruby
gem 'retail_calendars'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install retail_calendars

## Usage

    calendar = RetailCalendar::Calendar.new(type: 445)
    
    puts calendar.start_of_year(2020) # 2020-02-02
    puts calendar.start_of_year_by_date(Date.today) # 2020-02-02
    puts calendar.end_of_year(2020) # 2021-01-30
    puts calendar.start_of_month(2020, 1) # 2020-02-02
    puts calendar.end_of_month(2020, 1) # 2020-02-29
    puts calendar.weeks_in_year(2020) # 52
    puts calendar.retail_week_to_date(2, 2020) # {:start_week=>Sun, 09 Feb 2020, :end_week=>Sat, 15 Feb 2020}
    
## TODOS
Support different year start day and month.
    
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/retail_calendar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RetailCalendar project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/retail_calendar/blob/master/CODE_OF_CONDUCT.md).
