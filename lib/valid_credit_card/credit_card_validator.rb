require "valid_credit_card/credit_card"
require "active_model"
require "active_model/validations"

class CreditCardValidator < ActiveModel::EachValidator

  def default_options
    { card_types: ValidCreditCard::CreditCard::CARD_TYPES.keys.map(&:to_s) }
  end

  def validate_each(record, attribute, value)
    return unless value.present?

    options = default_options.merge(self.options)

    cc = ValidCreditCard::CreditCard.new(value)

    error(record, attribute) && return unless cc.valid?

    error(record, attribute) && return unless options[:card_types].include?(cc.card_type)
  end

  def error(record, attribute)
    record.errors.add(attribute, options[:message] || :invalid)
  end
end