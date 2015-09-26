require "valid_credit_card"

module ValidCreditCard
  class CreditCard
    CARD_TYPES = {
      visa: /\A4[0-9]{12}(?:[0-9]{3})?\z/,
      master_card: /\A5[1-5][0-9]{14}\z/,
      maestro: /(\A6759[0-9]{2}([0-9]{10})$)|(\A6759[0-9]{2}([0-9]{12})$)|(\A6759[0-9]{2}([0-9]{13})$)/,
      diners_club: /\A3(?:0[0-5]|[68][0-9])[0-9]{11}\z/,
      amex: /\A3[47][0-9]{13}\z/,
      discover: /\A6(?:011|5[0-9]{2})[0-9]{12}\z/,
      jcb: /\A(?:2131|1800|35\d{3})\d{11}\z/
    }

    attr_accessor :number

    # == Initializer
    def initialize(number)
      @number = number.to_s
    end

    def valid?
      (verify_luhn && strip_number.length >= 11 && card_type.present?) || is_test_number?
    end

    def card_type
      CARD_TYPES.select{ |k, v| (strip_number =~ v).present? }.keys[0].to_s
    end

    def is_test_number?
      ValidCreditCard.test_numbers.include?(strip_number)
    end

    def verify_luhn
      total = strip_number.reverse().split(//).inject([0,0]) do |accum, n|
        n = n.to_i
        accum[0] += (accum[1] % 2 == 1 ? rotate(n * 2) : n)
        accum[1] += 1
        accum
      end

      (total[0] % 10 == 0)
    end

    CARD_TYPES.each do |k, v|
      define_method "is_#{k.to_s}?" do
        (strip_number =~ v).present?
      end
    end

    protected

    def strip_number
      number.gsub(/\s/,'')
    end

    def rotate(n)
      n > 9 ? (n % 10 + 1) : n
    end
  end
end
