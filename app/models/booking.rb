class Booking < ActiveRecord::Base
  has_many :seating_arrangements
  has_many :tables, through: :seating_arrangements

  validates :name, :email, :number_of_visitors, :phone_number, :time, presence: true
end
