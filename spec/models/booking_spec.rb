require 'spec_helper'

describe Booking do
  let(:booking) { FactoryGirl.build(:booking) }
  subject { booking }

  it "should be valid and save" do
    booking.should be_valid
    booking.save.should be_true
  end

  it "should have errors if invalid" do
    required_fields = [:name, :quantity, :tags]
    required_fields.each { |field| booking[field] = nil }
    booking.should_not be_valid
    required_fields.each { |field| booking.errors.has_key?(field).should be_true }
  end

end
