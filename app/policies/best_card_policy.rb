class BestCardPolicy < ApplicationPolicy
  def best_card?
    user.present?  #users can request the best card
  end
end
