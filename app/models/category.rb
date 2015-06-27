class Category < ActiveRecord::Base
  belongs_to :product

  validates :name, :product_id, :created_at, :updated_at, presence: true
end
