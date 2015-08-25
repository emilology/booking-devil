class Booking < ActiveRecord::Base
  has_many :categories
  has_many :seating_arrangements
  has_many :tables, through: :seating_arrangements
  # accepts_nested_attributes_for :categories

  validates :number_of_visitors, :numericality => { :less_than_or_equal_to => 10 }, presence: true, if: :step1?
  validates :date, :time, presence: true, if: :step2?
  validates :dietary_preferences, presence: true, if: :step3?
  validates :name, :phone_number, presence: true, if: :step4?

  include MultiStepModel

  def self.total_steps
    6
  end
end
