# FavLanguage

This is a gem written as a part of a coding challenge. Given a GitHub username it tries to guess the user's favourite programming language.

The criteria used is the amount of bytes written in each language in all public owned repos of the user (omits forked repos).

## Installation

NB: It is not pushed to rubygems yet

This gem requires ruby >= 2.1

Add this line to your application's Gemfile:

```ruby
gem 'fav_language'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fav_language

## Using the binary

The gem has a command line interface. If you have the gem installed:

```
fav_lang -h
```

Example:
```
fav_lang -u tadast
> JavaScript: 418357 bytes written
```

If you have the repo cloned, you can do the above, just append `bundle exec exe/` e.g. `bundle exec exe/fav_lang -u tadast`

## Using the library

```ruby
require 'fav_language'
fav_stats = FavLanguage::Detector.new(username: 'tadast').favourite_languages
# returns an array of objects that have two properties: weight and language
# it is an array in case the user has two equally favourite languages
fav_stats.size
> 1
fav_stats.first.language
> "JavaScript"
fav_stats.first.weight
> 353577 # bytes commited in this language
```

## API rate limits

GitHub limits the number of requests you can make to the API. To increase this number you may want to get an oauth token. You can follow the instructions [on the github_api gem readme](https://github.com/peter-murach/github#3-authentication) to get the token. Then you can pass in the token value via the command line

```
fav_lang -u tadast -t <token>
```

or as an argument

```ruby
fav_stats = FavLanguage::Detector.new(username: 'tadast', token: "<token>")
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fav_language/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
