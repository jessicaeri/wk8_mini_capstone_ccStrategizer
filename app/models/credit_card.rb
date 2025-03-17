class CreditCard < ApplicationRecord
  belongs_to :user

  has_many :user_categories  #links cc to categories
  has_many :categories, through: :user_categories

  validates :name, presence:true
end
