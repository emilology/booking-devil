class Booking < ActiveRecord::Base
  has_many :seating_arrangements
  has_many :tables, through: :seating_arrangements

  validates :number_of_visitors, :time, presence: true, if: :step1?
  validates :chosen_table, presence: true, if: :step2?
  validates :name, :email, :phone_number, presence: true, if: :step3?

  include MultiStepModel

  def self.total_steps
    3
  end
end
