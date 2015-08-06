class BookedOut < ActiveRecord::Base
  belongs_to :table
  validates :day, :table, presence: true
end
