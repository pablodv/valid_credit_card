# ValidCreditCard

ActiveModel validation for credit card number.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'valid_credit_card'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install valid_credit_card

## Usage

### Use with ActiveModel

If you want to validate that it is a valid credit card number:
```ruby
class User < ActiveRecord::Base
  validates :cc_number, presence: true, credit_card: true
end
```

To validate that the credit card type:
```ruby
validates :cc_number, credit_card: { card_types: ['visa'] }
```

> Note that this gem will let an empty credit card number pass through so you will need to
> add `presence: true` if you require an credit card number

### Use without ActiveModel

```ruby
credit_card = ValidCreditCard::CreditCard.new(3530111333300000)
credit_card.valid? => true
credit_card.is_visa? => false
credit_card.is_jbc? => true
credit_card.card_type? => jbc
```

## Requirements
* Ruby-1.9
* Ruby-2.0
* Ruby-2.1
* Ruby-2.2
* JRuby-1.9

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
