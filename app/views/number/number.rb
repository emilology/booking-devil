class Number < ActiveRecord::Base
  gets.to_i.chomp
  validates :Number, presence: true
end

Number.create(number: 1-50).valid? # => true
Number.create(number: nil).valid? # => false
