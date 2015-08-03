class Table < ActiveRecord::Base
belongs_to :combination, class: Table

  # def combinable?
  #  returns true if it exists as a combination and its other table is free
  # end
  #
  # def divisible?
  #
  # end
end
