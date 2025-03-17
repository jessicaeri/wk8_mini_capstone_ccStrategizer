class UserCategory < ApplicationRecord
  belongs_to :credit_card
  belongs_to :category

  validates :points_per_dollar, numericality: { greater_than_or_equal_to: 0 }
end
