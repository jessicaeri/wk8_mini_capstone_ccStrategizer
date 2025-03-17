class CreditCardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)  #users can only see their own credit cards
    end
  end

  def create?
    user.user?  #users can create their own credit card
  end

  def destroy?
    record.user == user  #only owner can delete
  end
end
