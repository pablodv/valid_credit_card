require 'spec_helper'

class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class TestCreditCard < TestModel
  validates :number, credit_card: true
end

class TestCreditCardTypes < TestModel
  validates :number, credit_card: { card_types: ['visa'] }
end

describe ValidCreditCard do
  subject(:credit_card) { TestCreditCard.new(number: "") }

  describe "Basic validation" do
    it "should be valid when number is empty" do
      expect(credit_card.valid?).to be_truthy
    end

    it "should not be invalid when number is wrong" do
      credit_card = TestCreditCard.new(number: "111111111111")
      expect(credit_card.valid?).to be_falsey
    end

    it "should not be invalid when number is malformed" do
      credit_card = TestCreditCard.new(number: "1111111asdc")
      expect(credit_card.valid?).to be_falsey
    end

    it "should be valid when number is correct" do
      credit_card = TestCreditCard.new(number: "6011000990139424")
      expect(credit_card.valid?).to be_truthy
    end
  end

  describe "Credit Card types" do
    it "should be invalid when the number is not into the types" do
      credit_card = TestCreditCardTypes.new(number: "5105105105105100")
      expect(credit_card.valid?).to be_falsey
    end

    it "should be valid when the number is into the types" do
      credit_card = TestCreditCardTypes.new(number: "4111111111111111")
      expect(credit_card.valid?).to be_truthy
    end
  end
end
