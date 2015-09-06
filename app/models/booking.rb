class Booking < ActiveRecord::Base
  has_many :categories
  has_many :seating_arrangements
  has_many :tables, through: :seating_arrangements
  # accepts_nested_attributes_for :categories

  validates :date, :time, presence: true, if: :step1?
  validates :number_of_visitors, :numericality => { :less_than_or_equal_to => 10 }, presence: true, if: :step1?
  validates_format_of :phone_number, :with => /[0-9]/, :on => :create, if: :step2?
  validates :dietary_preferences, :name, :phone_number, presence: true, if: :step2?

  include MultiStepModel

  def self.total_steps
    3
  end
end
