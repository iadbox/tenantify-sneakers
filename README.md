# Tenantify::Sneakers

Gem to make [Sneakers](https://github.com/jondot/sneakers) work with the [Tenantify](https://github.com/qustodian/tenantify) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tenantify-sneakers'
```

And then execute:

    $ bundle

## Usage

This gem provides a `Tenantify::Sneakers::Worker` module to be used instead
of `Sneakers::Worker`, that executes the `#work` (or `#work_with_params`) method
in the context of a particular tenant.

The tenant name must be stored in the `:tenant` header of the message metadata.

To create a tenantified Sneakers worker:

```ruby
require 'tenantify/sneakers'

class Worker
  prepend Tenantify::Sneakers::Worker

  def work msg
    # do work...
  end
end
```

*IMPORTANT:* For the gem to work you must *prepend* the `Tenantify::Sneakers::Worker`
on the class where you are defining the `#work` or `#work_with_params` method.
If you prepend the `Tenantify::Sneakers::Worker` to a class and then you inherit from
that class and define the `#work` method on the child class, the gem is not going to
work.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tenantify-sneakers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
