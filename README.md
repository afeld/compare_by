# Compare By

A better version of Ruby's [`Comparable`](http://ruby-doc.org/core-2.3.0/Comparable.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'compare_by'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install compare_by

## Usage

Suppose you have the following class:

```ruby
class SomeClass
  attr_accessor :some_attr, :some_other_attr

  # ...
end
```

To ensure the uniqueness of each instance of the class, `include` the `CompareBy` module and specify which attribute(s)/method(s) you want the instances compared by.

```ruby
require 'compare_by'

class SomeClass
  include CompareBy

  attr_accessor :some_attr, :some_other_attr
  compare_by :some_attr

  # ...
end
```

If you then made two instances of `SomeClass` with the same value of `some_attr`, they would be considered equivalent.

```ruby
instance1 = SomeClass.new
instance1.some_attr = 'foo'
instance2 = SomeClass.new
instance2.some_attr = 'foo'

instance1 == instance2 #=> true
instance1.eql?(instance2) #=> true
[instance1, instance2].uniq #=> [instance1]
```

Note that you can specify one or more attribute(s)/method(s) for instances to be compared by, and each will be considered in order.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/compare_by. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
