class SeatingArrangement < ActiveRecord::Base
  belongs_to :booking
  belongs_to :table
end
