class Category < ApplicationRecord
  validates :name, presence: true

  has_many :user_categories  #connects to user cc through the join table
  has_many :credit_cards, through: :user_categories
end
