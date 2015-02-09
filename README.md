# Rewards

BSkyB Rewards Service

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Rewards'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Rewards

## Usage

Construct a Rewards::Service (passing it a Eligibility::Service to work
from), then tell it to discover the rewards for a given account number
and subscription package.  

To run the test suite use `bundle exec rake test`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/Rewards/fork )
2. Create your feature branch (`git checkout -b my-new-feature`), with
   full tests
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
